//
//  AlertTable.h
//  TableInAlert
//
//  Created by Line_Hu on 14-2-20.
//  Copyright (c) 2014年 Alpha. All rights reserved.
//

@class AlertTable;
@protocol AlertTableDelegate <NSObject>
- (void)cancelButtonClicked:(AlertTable *)alertTable;
- (void)confirmButtonClicked:(AlertTable *)alertTable;
@end

typedef void(^SeletedTable)(NSInteger);

#import <UIKit/UIKit.h>
@interface AlertTable : UIView<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (assign, nonatomic) id<AlertTableDelegate>delegate;
@property (strong, nonatomic) UITableView *mainTable;
@property (strong, nonatomic) NSMutableArray *dataSources;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *insideContainerView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) SeletedTable tappedBlock;
- (id)initWithParentViewController:(UIViewController *)parentController seletedBlock:(SeletedTable)tapped;
- (void)showWithTitle:(NSString *)title;
@end
