//
//  AlertTable.m
//  TableInAlert
//
//  Created by Line_Hu on 14-2-20.
//  Copyright (c) 2014年 Alpha. All rights reserved.
//

#import "AlertTable.h"
#import "ViewController.h"

#define CONTAINER_WIDTH 260
#define CONTAINER_HEIGHT 390
#define INSIDE_CONTAINER_WIDTH 240
#define INSIDE_CONTAINER_HEIGHT 280
#define INSET_TOP_BOTTOM 60
#define INSET_LEFT_RIGHT 40
#define INSIDE_INSET_TOP_BOTTOM 40
#define INSIDE_INSET_LEFT_RIGHT 20
#define BUTTON_WIDTH 65
#define BUTTON_HEIGHT 30

@interface AlertTable()
{
    
}
@property(strong, nonatomic) ViewController *parentVC;
@end

@implementation AlertTable
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithParentViewController:(ViewController *)parentController seletedBlock:(SeletedTable)tapped
{
    self = [super initWithFrame:parentController.view.frame];
    if(self)
    {
        self.parentVC = parentController;
        self.tappedBlock = tapped;
        //NSLog(@"cur:%d",parentController.currentOrientation);
        _parentView = parentController.view;
        self.frame = parentController.view.frame;
        //NSLog(@"width:%f,%f",self.frame.size.width,self.frame.size.height);
        [_parentVC addObserver:self forKeyPath:@"currentOrientation" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)modifyContainerAccordingToOrientation:(UIDeviceOrientation)ori
{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.containerView)
    {
        UIDeviceOrientation ori = [[change objectForKey:@"new"] integerValue];
        if (ori != UIDeviceOrientationPortraitUpsideDown)
        {
            //如果直接更改self.frame会出问题,所以加个变量来表示旋转后的rect
            CGRect sourceFrame;
            if(_parentVC.currentOrientation == UIDeviceOrientationPortrait)
            {
                sourceFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            }
            else if(_parentVC.currentOrientation == UIDeviceOrientationLandscapeRight || _parentVC.currentOrientation == UIDeviceOrientationLandscapeLeft)
            {
                sourceFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
            }
            _containerView.frame = UIEdgeInsetsInsetRect(sourceFrame, UIEdgeInsetsMake(INSET_TOP_BOTTOM, INSET_LEFT_RIGHT, INSET_TOP_BOTTOM, INSET_LEFT_RIGHT));
            //NSLog(@"self:%f,%f,%f,%f",self.frame.origin.x,self.frame.origin.y, self.frame.size.width,self.frame.size.height);
            //self.backgroundColor = [UIColor redColor];
            //NSLog(@"ct:%f,%f,%f.%f",_containerView.frame.origin.x,_containerView.frame.origin.y, _containerView.frame.size.width,_containerView.frame.size.height);
            //NSLog(@"pr:%f,%f,%f,%f",_parentVC.view.frame.origin.x,_parentVC.view.frame.origin.y,_parentVC.view.frame.size.width,_parentVC.view.frame.size.height);
            _insideContainerView.frame = UIEdgeInsetsInsetRect(_containerView.bounds, UIEdgeInsetsMake(INSIDE_INSET_TOP_BOTTOM, INSIDE_INSET_LEFT_RIGHT, INSIDE_INSET_TOP_BOTTOM, INSIDE_INSET_LEFT_RIGHT));
            _mainTable.frame = CGRectMake(0, 0, _insideContainerView.frame.size.width, _insideContainerView.frame.size.height);
            _cancelButton.frame = CGRectMake(_insideContainerView.frame.origin.x, _insideContainerView.frame.size.height + INSET_LEFT_RIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
            _confirmButton.frame = CGRectMake(_insideContainerView.frame.origin.x+BUTTON_WIDTH+_containerView.frame.size.width - BUTTON_WIDTH * 2 - _insideContainerView.frame.origin.x*2, _insideContainerView.frame.size.height+INSET_LEFT_RIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
        }
    }
}

- (void)showWithTitle:(NSString *)title;
{
    
    [self createContainerView];
    _titleLabel.text = title;
    _containerView.layer.opacity = 0.5f;
    _containerView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:_containerView];
    [_parentView addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         _containerView.layer.opacity = 1.0f;
                         _containerView.backgroundColor = [UIColor whiteColor];
                         _containerView.layer.transform = CATransform3DMakeScale(1, 1, 1);
					 }
					 completion:NULL
     ];

}

- (void)dismiss
{
    //remove observer
    [_parentVC removeObserver:self forKeyPath:@"currentOrientation"];
    _containerView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _containerView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         _containerView.layer.transform = CATransform3DMakeScale(0.5f, 0.6f, 1.0f);
                         _containerView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

- (void)createContainerView
{
    //根据当前屏幕的orientation来确定self的rect
    UIDeviceOrientation deviceOrientation = _parentVC.currentOrientation;
    if(deviceOrientation == UIDeviceOrientationLandscapeLeft | deviceOrientation == UIDeviceOrientationLandscapeRight)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    else if(deviceOrientation == UIDeviceOrientationPortrait)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    else
    {
        //记录之前的旋转状态,主要是为了防止在upsidedown的时候尺寸不对。如果从landscape旋转到upsidedown，这时弹出的frame应该还是landscape下得frame大小
        if(_parentVC.previousOrientation == UIDeviceOrientationPortrait)
        {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        else if(_parentVC.previousOrientation == UIDeviceOrientationLandscapeLeft || _parentVC.previousOrientation == UIDeviceOrientationLandscapeRight)
        {
            //NSLog(@"yo");
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        }
    }
    
    CGRect screenRect = self.frame;
    self.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _containerView = [[UIView alloc] init];
    _containerView.frame = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsetsMake(INSET_TOP_BOTTOM, INSET_LEFT_RIGHT, INSET_TOP_BOTTOM, INSET_LEFT_RIGHT));
    //NSLog(@"%f,%f",self.frame.size.width,self.frame.size.height);
    _containerView.layer.cornerRadius = 5.0f;
//    _containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _insideContainerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(_containerView.bounds, UIEdgeInsetsMake(INSIDE_INSET_TOP_BOTTOM, INSIDE_INSET_LEFT_RIGHT, INSIDE_INSET_TOP_BOTTOM, INSIDE_INSET_LEFT_RIGHT))];
//    _insideContainerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _insideContainerView.layer.cornerRadius = 3.0f;
    _insideContainerView.layer.borderWidth = 1.0f;
    _insideContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_containerView.frame.size.width - INSIDE_CONTAINER_WIDTH)/2,0, INSIDE_CONTAINER_WIDTH, 40)];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin ;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    [_containerView addSubview:_titleLabel];
    [_containerView addSubview:_insideContainerView];
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _insideContainerView.frame.size.width, _insideContainerView.frame.size.height) style:UITableViewStylePlain];
    _mainTable.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    [_insideContainerView addSubview:_mainTable];
    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.frame = CGRectMake(_insideContainerView.frame.origin.x, _insideContainerView.frame.size.height + INSET_LEFT_RIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_containerView addSubview:_cancelButton];
    [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];

    [_confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.frame = CGRectMake(_insideContainerView.frame.origin.x+BUTTON_WIDTH+_containerView.frame.size.width - BUTTON_WIDTH * 2 -_insideContainerView.frame.origin.x*2, _insideContainerView.frame.size.height+INSET_LEFT_RIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    [_containerView addSubview:_confirmButton];

}

- (void)clickCancelButton
{
    [self.delegate cancelButtonClicked:self];
    [self dismiss];
}

- (void)clickConfirmButton
{
    [self.delegate confirmButtonClicked:self];
    [self dismiss];
}

- (void)setDataSources:(NSMutableArray *)dataSources
{
    _dataSources = dataSources;
    [_mainTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [_dataSources objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tappedBlock(indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
