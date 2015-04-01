//
//  JSONTableViewController.m
//  JSONSorter
//
//  Created by Troy Barrett on 6/28/14.
//
//

#import "JSONTableViewController.h"
#import "BasicCell.h"

@interface JSONTableViewController ()

@end

@implementation JSONTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self parseLayerDataIntoArrays];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allKeys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    BasicCell *cell = (BasicCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BasicCell" owner:self options:nil];
        cell = [nib objectAtIndex:0]; // cool, this is how we use custom cells; LEARNING!
    }
    
    id key = self.allKeys[indexPath.row];
    
    cell.keyLabel.text = [key description];
    
    NSString *dataType = [NSString stringWithFormat:@"%@", [self.allValues[indexPath.row] class]];
    // ^ creates string of data type from allValues array
    
    cell.dataTypeLabel.text = dataType;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicCell *cell = (BasicCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *key = cell.keyLabel.text;
    NSString *dataType = cell.dataTypeLabel.text;
    
    NSLog(@" Selected Key: %@ of DataType : %@", key, dataType);
    
    if ([self.layerData isKindOfClass:[NSDictionary class]])
    {
        [self buildNextLevelFromDictionary:key];
    }
    
    else if ([self.layerData isKindOfClass:[NSArray class]])
    {
        [self buildNextLevelFromArray:indexPath];
    }
    
}

#pragma mark - Parsing Methods

- (void)parseJSON
{
    NSError *error = nil;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"jsondata" ofType:@"txt"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSData *jsonData = [jsonContents dataUsingEncoding:NSUTF8StringEncoding];
    
    self.layerData =
    [NSJSONSerialization JSONObjectWithData: jsonData
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
}

- (void)parseLayerDataIntoArrays
{
    if ([self.navigationController.viewControllers count] < 2)
    {
        [self parseJSON];
    }
    
    if ([self.layerData isKindOfClass:[NSDictionary class]])
    {
        self.allKeys = [(NSDictionary *)self.layerData allKeys];
        self.allValues = [(NSDictionary *)self.layerData allValues];
        // ^ will be used for data type text field during cell population
    }
    else if ([self.layerData isKindOfClass:[NSArray class]])
    {
        self.allKeys = self.layerData;
        self.allValues = self.layerData;
        // ^ by setting equal removed need to descern between dictionary or array during cell population
    }
}

#pragma mark - Build Next Level of JSON

#pragma mark From Selected Dictionary
- (void)buildNextLevelFromDictionary:(NSString *)key
{
    if ([[self.layerData objectForKey:key] isKindOfClass:[NSDictionary class]])
    {
        [self nextLevelFromDictionaryIsDictionaryClass:key];
    }
    
    else if ([[self.layerData objectForKey:key] isKindOfClass:[NSArray class]])
    {
        [self nextLevelFromDictionaryIsArrayClass:key];
    }
}

- (void)nextLevelFromDictionaryIsDictionaryClass:(NSString *)key
{
    NSDictionary *nextLevel= [self.layerData objectForKey:key];
    
    [self buildFinalNextLevel:nextLevel];
}

- (void)nextLevelFromDictionaryIsArrayClass:(NSString *)key
{
    NSArray *nextLevel= [self.layerData objectForKey:key];
    
    [self buildFinalNextLevel:nextLevel];
}

#pragma mark From Selected Array
- (void)buildNextLevelFromArray:(NSIndexPath *)indexPath
{
    NSArray *nextLevel= self.layerData[indexPath.row];
    
    [self buildFinalNextLevel:nextLevel];
}

#pragma mark
- (void)buildFinalNextLevel:(id)nextLevel
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    JSONTableViewController *JSON_TVC = [storyboard instantiateViewControllerWithIdentifier:@"JSON_TVC"];
    
    JSON_TVC.layerData = nextLevel;
    
    [self.navigationController pushViewController:JSON_TVC animated:YES];
}

#pragma mark - Boilerplate (unused)
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
*/
@end
