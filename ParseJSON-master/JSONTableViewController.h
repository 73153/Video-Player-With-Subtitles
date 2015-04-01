//
//  JSONTableViewController.h
//  JSONSorter
//
//  Created by Troy Barrett on 6/28/14.
//
//

#import <UIKit/UIKit.h>

@interface JSONTableViewController : UITableViewController

@property (strong, nonatomic) id layerData;
@property (strong, nonatomic) NSArray *allKeys;
@property (strong, nonatomic) NSArray *allValues;

@end
