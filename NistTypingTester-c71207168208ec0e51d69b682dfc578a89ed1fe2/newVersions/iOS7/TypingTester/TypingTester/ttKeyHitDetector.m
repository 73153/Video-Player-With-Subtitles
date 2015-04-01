//
//  ttKeyHitDetector.m
//  TypingTester
//
//  Created by Matthew Kerr on 12/11/13.
//

#import "ttKeyHitDetector.h"
#import "ttHitBox.h"

@implementation ttKeyHitDetector
{
    NSMutableArray *iPhone35InchPortraitHitboxes;
    NSMutableArray *iPhone35InchLandscapeHitboxes;
    NSMutableArray *iPhone4InchPortraitHitboxes;
    NSMutableArray *iPhone4InchLandscapeHitboxes;
    NSMutableArray *iPadPortraitHitboxes;
    NSMutableArray *iPadLandscapeHitboxes;
    CGSize screenSize;
}

static ttKeyHitDetector *instance = nil;

+(ttKeyHitDetector*) Instance
{
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{ instance = [[self alloc] init];});
    
    return instance;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        // get the screen size
        screenSize = [[UIScreen mainScreen]bounds].size;
        // define the hitboxes
        iPhone35InchLandscapeHitboxes = [[NSMutableArray alloc]initWithCapacity:4];
        [iPhone35InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0,244,65,37) forKeyType:SpecialKeyShift]];
        [iPhone35InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0,283,95,37) forKeyType:SpecialKeyKeyboardChange]];
        [iPhone35InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(418,242,72,36) forKeyType:SpecialKeyDelete]];
        [iPhone35InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(458,287,95,37) forKeyType:SpecialKeyReturn]];
        // Landscape mode reports x,y coordinates in an unrotated manner so what looks like height physically is actually width
        [iPhone35InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(320, 0, -158, 568) forKeyType:SpecialKeyOffKeyboard]];
        
        iPhone35InchPortraitHitboxes =  [[NSMutableArray alloc]initWithCapacity:4];
        [iPhone35InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 375, 49, 49) forKeyType:SpecialKeyShift]];
        [iPhone35InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 425, 79, 49) forKeyType:SpecialKeyKeyboardChange]];
        [iPhone35InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(275, 468, 45, 45) forKeyType:SpecialKeyDelete]];
        [iPhone35InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(246, 523, 74, 45) forKeyType:SpecialKeyReturn]];
        [iPhone35InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 0, 320, 352) forKeyType:SpecialKeyOffKeyboard]];
        
        iPhone4InchLandscapeHitboxes = [[NSMutableArray alloc]initWithCapacity:4];
        [iPhone4InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0,242,90,42) forKeyType:SpecialKeyShift]];
        [iPhone4InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0,282,124,38) forKeyType:SpecialKeyKeyboardChange]];
        [iPhone4InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(474,242,94, 40) forKeyType:SpecialKeyDelete]];
        [iPhone4InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(458,292,110, 28) forKeyType:SpecialKeyReturn]];
         // Landscape mode reports x,y coordinates in an unrotated manner so what looks like height physically is actually width
        [iPhone4InchLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(320, 0, -156, 480) forKeyType:SpecialKeyOffKeyboard]];
        
        iPhone4InchPortraitHitboxes = [[NSMutableArray alloc]initWithCapacity:4];
        [iPhone4InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 467, 58, 48) forKeyType:SpecialKeyShift]];
        [iPhone4InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 520, 48, 78) forKeyType:SpecialKeyKeyboardChange]];
        [iPhone4InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(276, 467, 44, 48) forKeyType:SpecialKeyDelete]];
        [iPhone4InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(250, 532, 70, 36) forKeyType:SpecialKeyReturn]];
        [iPhone4InchPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 0, 320, 264) forKeyType:SpecialKeyOffKeyboard]];
        
        iPadLandscapeHitboxes = [[NSMutableArray alloc]initWithCapacity:7];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 595, 88, 84) forKeyType:SpecialKeyShift]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(908, 595, 116, 84) forKeyType:SpecialKeyShiftRight]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 680, 270, 88) forKeyType:SpecialKeyKeyboardChange]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(816, 680, 116, 88) forKeyType:SpecialKeyKeyboardChangeRight]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(930, 417, 90, 90) forKeyType:SpecialKeyDelete]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(870, 510, 150, 70) forKeyType:SpecialKeyReturn]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(933, 680, 87, 88) forKeyType:SpecialKeyHideKeyboard]];
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(92, 594, 178, 83) forKeyType:SpecialKeyUndo]];
         // Landscape mode reports x,y coordinates in an unrotated manner so what looks like height physically is actually width
        [iPadLandscapeHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(768, 0, -415, 1024) forKeyType:SpecialKeyOffKeyboard]];
        
        iPadPortraitHitboxes = [[NSMutableArray alloc]initWithCapacity:7];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 896, 66, 62) forKeyType:SpecialKeyShift]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(685, 896, 83, 62) forKeyType:SpecialKeyShiftRight]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 959, 200, 62) forKeyType:SpecialKeyKeyboardChange]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(612, 961, 88, 59) forKeyType:SpecialKeyKeyboardChangeRight]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(696, 760, 69, 69) forKeyType:SpecialKeyDelete]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(660, 843, 104, 35) forKeyType:SpecialKeyReturn]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(700, 960, 55, 55) forKeyType:SpecialKeyHideKeyboard]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(70, 895, 135, 61) forKeyType:SpecialKeyUndo]];
        [iPadPortraitHitboxes addObject:[[ttHitBox alloc]initWithRect:CGRectMake(0, 0, 768, 759) forKeyType:SpecialKeyOffKeyboard]];
        
    }
    return self;
}


-(SpecialKey)GetKeyAtPoint:(CGPoint)point
{
    NSArray *activeHitboxes = [self getHitboxList];
    for(ttHitBox *hitbox in activeHitboxes)
    {
        if ([hitbox isPointInHitbox:point] == true)
        {
            return hitbox.keyType;
        }
    }
    return SpecialKeyNone;
}

-(NSArray*)getHitboxList
{
    // determine the orientation
    BOOL isLandscape = NO;
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation]))
    {
        isLandscape = YES;
    }

    //determine the device type
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            if (isLandscape) return iPadLandscapeHitboxes;
            else return iPadPortraitHitboxes;
            
        case UIUserInterfaceIdiomPhone:
            if (screenSize.height == 568.0f) //iPhone 4 inch screen
            {
                if(isLandscape) return iPhone4InchLandscapeHitboxes;
                else return iPhone4InchPortraitHitboxes;
            }
            else if (screenSize.height == 480.0f) //iPhone 3.5 inch screen
            {
                if(isLandscape) return iPhone35InchLandscapeHitboxes;
                else return iPhone35InchPortraitHitboxes;
            }
            else // some other screen size ....
            {
                return [[NSArray alloc]init];
            }
            break;
    }
    return [[NSArray alloc]init];
}


@end
