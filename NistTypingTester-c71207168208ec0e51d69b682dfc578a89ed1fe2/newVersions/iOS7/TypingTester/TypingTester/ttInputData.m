//
//  ttInputData.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import "ttInputData.h"
#import "ttUtilities.h"
#import "ttFilter.h"
#import "ttProficiencyItem.h"
#import "ttTestEntity.h"
#import "ttSettings.h"

@implementation ttInputData
{
    NSMutableArray *filterBuilder;
    NSMutableArray *proficiencyBuilder;
    NSMutableArray *entityBuilder;

    ttSettings *settings;
}

static ttInputData *instance = nil;

+(ttInputData*) Instance
{
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{ instance = [[self alloc] init];});
    
    return instance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

-(void)clearData
{
    filterBuilder = [[NSMutableArray alloc]init];
    proficiencyBuilder = [[NSMutableArray alloc]init];
    entityBuilder = [[NSMutableArray alloc]init];
    self.entityNumberError = false;
    self.entityFilterError = false;
}

-(void)loadDataFile:(NSString *)filepath
{
    // allocate arrays to use when building the lists
    filterBuilder = [[NSMutableArray alloc]init];
    proficiencyBuilder = [[NSMutableArray alloc]init];
    entityBuilder = [[NSMutableArray alloc]init];
    // build the path to the inputstrings file and load it
    NSString* documentsDirectory = [ttUtilities documentsDirectory];
    NSString *inputFile = [documentsDirectory stringByAppendingPathComponent:@"inputStrings.xml"];
    NSURL *url = [NSURL fileURLWithPath:inputFile];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
    // sort the arrays
    NSSortDescriptor *itemIdDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemId" ascending:YES];
    NSArray *sortDescriptors = @[itemIdDescriptor];
    self.entities = [entityBuilder sortedArrayUsingDescriptors:sortDescriptors];
    self.proficiencyItems = [proficiencyBuilder sortedArrayUsingDescriptors:sortDescriptors];
    self.filters = [[NSArray alloc]initWithArray:filterBuilder];
    // set the builder arrays to nil
    filterBuilder = nil;
    proficiencyBuilder = nil;
    entityBuilder = nil;
}

-(NSArray*) getPhrasesForGroupId:(NSUInteger)groupId
{
    NSMutableArray *results = [[NSMutableArray alloc]init];
    for(int i = 0; i < self.proficiencyItems.count; i++)
    {
        ttProficiencyItem *item = [self.proficiencyItems objectAtIndex:i];
        if (item.groupId == groupId)
        {
            [results addObject:item];
        }
    }
    return [[NSArray alloc]initWithArray:results];
}

-(NSArray*) randomizeArray:(NSArray*)input withRandomSeedValue:(NSUInteger)seed
{
    NSMutableArray *base = [[NSMutableArray alloc]initWithArray:input];
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:base.count];
    // seed the PRNG
    srandom(seed);
    // randomize the array
    while(base.count > 0)
    {
        NSUInteger value = [self randomWithMinValue:0 andMaxValue:base.count];
        [result addObject:[base objectAtIndex:value]];
        [base removeObjectAtIndex:value];
    }
    
    return [[NSArray alloc]initWithArray:result];
}

-(NSArray*) getEntities
{
    NSMutableArray *results = [[NSMutableArray alloc]initWithCapacity:settings.entitiesPerSession];
    NSMutableArray *filtered = [[NSMutableArray alloc]init];
    
    // step through the array and apply the filters
    for (NSUInteger current = 0; current < self.entities.count; current++)
    {
        ttTestEntity *entity = [self.entities objectAtIndex:current];
        if ([self doesEntityPassFilters:entity]) [filtered addObject:entity];
    }
    // no entiites matched the filters
    if (filtered.count <= 0)
    {
        self.entityFilterError = YES;
        [filtered addObjectsFromArray:self.entities];
    }
    
    // Are we randomly selecting from the available strings?
    if (settings.randomStringSelection == YES)
    {
        if (settings.useRandomStringSelectionSeed)
        {
            settings.effectiveSelectionSeed = settings.stringSelectionSeed;
        }
        else
        {
            settings.effectiveSelectionSeed = time(NULL);
        }
        filtered = [NSMutableArray arrayWithArray:[self randomizeArray:filtered withRandomSeedValue:settings.effectiveSelectionSeed]];
    }
    
    NSUInteger iEntitiesToUse = settings.entitiesPerSession;
    // check for more required entities than available
    if (settings.entitiesPerSession > filtered.count)
    {
        self.entityNumberError = YES;
        iEntitiesToUse = filtered.count;
    }
    
    //for(int i = 0; i < settings.entitiesPerSession; i++)
    for(int i = 0; i < iEntitiesToUse; i++)
    {
        [results addObject:[filtered objectAtIndex:i]];
    }
    
    if(settings.randomStringOrder == YES)
    {
        if(settings.useRandomStringOrderSeed == YES)
        {
            settings.effectiveOrderSeed = settings.stringOrderSeed;
        }
        else
        {
            settings.effectiveOrderSeed = time(NULL);
        }
        return [self randomizeArray:results withRandomSeedValue:settings.effectiveOrderSeed];
    }
    else return [NSArray arrayWithArray:results];
}


-(BOOL)doesEntityPassFilters:(ttTestEntity*)entity
{
    BOOL filtersMet = YES;
    
    if (settings.useGroupId == YES && entity.groupId != settings.selectedGroup) filtersMet = NO;
    // TODO :: add date filtering
    // TODO :: add additional filtering
    return filtersMet;
}

/* Would like a semi-open interval [min, max) */
-(NSUInteger) randomWithMinValue:(NSUInteger)min andMaxValue:(NSUInteger) max
{
    NSUInteger base_random = random(); /* in [0, RAND_MAX] */
    if (RAND_MAX == base_random) return [self randomWithMinValue:min andMaxValue:max];
    /* now guaranteed to be in [0, RAND_MAX) */
    NSUInteger range       = max - min,
    remainder   = RAND_MAX % range,
    bucket      = RAND_MAX / range;
    /* There are range buckets, plus one smaller interval
     within remainder of RAND_MAX */
    if (base_random < RAND_MAX - remainder)
    {
        return min + base_random/bucket;
    }
    else
    {
        return [self randomWithMinValue:min andMaxValue:max];
    }
}

#pragma -mark ttXmlParserDelegate functions
-(void) finishedChild:(NSString*)s;
{
    self.child = nil;
}

#pragma -mark NSXMLParserDelegate functions
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"filterItem"])
    {
        ttFilter *newFilter = [[ttFilter alloc]init];
        [filterBuilder addObject:newFilter];
        [newFilter parseElementAttributes:attributeDict];
        [newFilter startElementNamed:elementName withParentParser:self];
        self.child = newFilter;
        parser.delegate = newFilter;
    }
    else if ([elementName isEqualToString:@"proficiencyInput"])
    {
        ttProficiencyItem* newItem = [[ttProficiencyItem alloc]init];
        [proficiencyBuilder addObject:newItem];
        [newItem parseElementAttributes:attributeDict];
        [newItem startElementNamed:elementName withParentParser:self];
        self.child = newItem;
        parser.delegate = newItem;
    }
    else if ([elementName isEqualToString:@"memorizationInput"])
    {
        ttTestEntity *newEntity = [[ttTestEntity alloc]init];
        [entityBuilder addObject:newEntity];
        [newEntity parseElementAttributes:attributeDict];
        [newEntity startElementNamed:elementName withParentParser:self];
        self.child = newEntity;
        parser.delegate = newEntity;
    }
}

@end
