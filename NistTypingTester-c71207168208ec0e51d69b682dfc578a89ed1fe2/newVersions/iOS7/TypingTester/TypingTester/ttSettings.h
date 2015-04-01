//
//  ttSettings.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/8/13.
//

#import <Foundation/Foundation.h>


@interface ttSettings : NSObject
{
    
}

@property (nonatomic, assign) NSUInteger entitiesPerSession;
@property (nonatomic, assign) NSUInteger entriesPerEntitiy;
@property (nonatomic, assign) NSUInteger forcedPracticeRounds;
@property (nonatomic, assign) bool showQuitButton;
@property (nonatomic, assign) bool showSkipButton;
@property (nonatomic, assign) bool randomStringOrder;
@property (nonatomic, assign) bool randomStringSelection;
@property (nonatomic, assign) NSUInteger stringOrderSeed;
@property (nonatomic, assign) NSUInteger stringSelectionSeed;
@property (nonatomic, assign) bool useRandomStringOrderSeed;
@property (nonatomic, assign) bool useRandomStringSelectionSeed;
@property (nonatomic, copy) NSString *quitString;
@property (nonatomic, copy) NSString *skipString;
@property (nonatomic, assign) bool useGroupId;
@property (nonatomic, assign) NSUInteger selectedGroup;
@property (nonatomic, assign) bool firstRun;
@property (nonatomic, assign) bool enableHideButtonOnPracticeScreen;
@property (nonatomic, assign) bool enableSkipButton;
@property (nonatomic, assign) bool enableQuitButton;
@property (nonatomic, assign) NSUInteger  proficiencyGroup;
@property (nonatomic, assign) NSUInteger verifyRounds;
@property (nonatomic, assign) bool disableFreePractice;
@property (nonatomic, assign) bool disableFreePracticeTextField;
@property (nonatomic, assign) NSUInteger effectiveOrderSeed;
@property (nonatomic, assign) NSUInteger effectiveSelectionSeed;


+(ttSettings*) Instance;

-(void) registerDefaults;
-(void) resetToDefaults;

+(void) copyInitialFilesShouldOverwrite:(BOOL)overwrite;

-(NSString*)getSettings;





@end
