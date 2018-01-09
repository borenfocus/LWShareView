//
//  LWViewController.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LWViewController.h"
#import "ArtShareSheetView.h"
#import <Masonry.h>

@interface LWViewController ()
@property (nonatomic, strong) ArtShareSheetView *sheetView;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation LWViewController

- (void)showShareSheetView
{
    ArtShareSheetView *shareSheetView = [[ArtShareSheetView alloc] init];
//    shareSheetView.shareToolBarItems = self.shareToolBarItems;
//    shareSheetView.showThirdSharePlatform = self.shareLinkString.length > 0;
    [self.view.window addSubview:shareSheetView];
    self.sheetView = shareSheetView;
    self.sheetView.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width-20, 314);
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
    }];

}

- (void)hideSheetView
{
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height ;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [self.sheetView removeFromSuperview];
        self.sheetView = nil;
        self.isShowing = NO;
        [self.maskView removeFromSuperview];
    }];
}


- (IBAction)shareDidClick:(UIButton *)sender {
    if (self.isShowing) {return;}
    self.isShowing = YES;
    UIWindow *keyWindow = self.view.window;
    NSLog(@"%@",NSStringFromCGRect(keyWindow.frame));
    
    // 添加maskView
    UIView *maskView = [[UIView alloc] init];
    [keyWindow addSubview:maskView];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    [maskView layoutIfNeeded];
    NSLog(@"%@",NSStringFromCGRect(maskView.frame));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSheetView)];
    [maskView addGestureRecognizer:tap];
    
    [self showShareSheetView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Lazy Load

- (ArtShareSheetView *)sheetView
{
    if (_sheetView == nil) {
        _sheetView = [[ArtShareSheetView alloc] init];
        
    }
    return _sheetView;
}
@end