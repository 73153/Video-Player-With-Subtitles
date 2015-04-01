//
//  DetailViewController.h
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Password;

@protocol DetailViewControllerDelegate
- (void)UpdateRecord:(Password*) item;
@end

@interface DetailViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id <DetailViewControllerDelegate> delegate;
@property (strong, nonatomic) Password *record;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesTxt;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
