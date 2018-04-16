//
//  RCTNativeLoading.m
//  RCTNativeLoading
//
//  Created by 欧阳伟坚 on 2018/4/13.
//  Copyright © 2018年 欧阳伟坚. All rights reserved.
//

#import "RCTNativeLoading.h"

#define iPhone6pScreenWidth 375.0
#define iPhone6pScreenHeight 667.0
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height
//功能页面按钮的自动布局
#define AutoLayoutFunctionBtnSizeX(X) KScreenWidth*(X)/iPhone6pScreenWidth
#define AutoLayoutFunctionBtnSizeY(Y) KScreenHeight*(Y)/iPhone6pScreenHeight
#define AutoLayoutFunctionBtnWidth(width) KScreenWidth*(width)/iPhone6pScreenWidth
#define AutoLayoutFunctionBtnHeight(height) KScreenHeight*(height)/iPhone6pScreenHeight

@interface NativeLoading ()

@property (strong, nonatomic) UIViewController *vc;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView ;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *textStr;
@end

@implementation NativeLoading

@synthesize bridge = _bridge;

- (instancetype)init {
    if (self = [super init]) {
        
        self.vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
    }
    return  self;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(show:(NSString *)msg){

    if(msg.length == 0) {
        [self showLoadingWithoutStr];
    }
    else {
        [self showLoading:msg];
    }
}
                  
RCT_EXPORT_METHOD(hide){
    [self hideLoading];
}

-(void)showLoadingWithoutStr {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.activityIndicatorView.animating) {
            
        }
        else {
            // 背景层
            self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoLayoutFunctionBtnWidth(120), AutoLayoutFunctionBtnHeight(120))];
            self.bgView.backgroundColor = [UIColor blackColor];
            self.bgView.center = self.vc.view.center;
            self.bgView.alpha = 0.7;
            self.bgView.layer.cornerRadius = 10.0f;
            [self.vc.view addSubview:self.bgView];
            
            // 加载图效果
            CGFloat activityIndicatorViewX = self.bgView.frame.origin.x + (self.bgView.frame.size.width - 40) / 2;
            CGFloat activityIndicatorViewY = self.bgView.frame.origin.y + (self.bgView.frame.size.height - 40) / 2;
            
            self.activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(activityIndicatorViewX, activityIndicatorViewY, 40, 40)];
            //        CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
            //        self.activityIndicatorView.transform = transform;
            [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [self.activityIndicatorView setBackgroundColor:[UIColor clearColor]];
            [self.vc.view addSubview:self.activityIndicatorView];
            
            [self.activityIndicatorView startAnimating];
        }
    });
}

-(void)showLoading:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.activityIndicatorView.animating) {
            if ([msg isEqualToString:self.textStr.text]) {
                
            }
            else{
                self.textStr.text = msg;
            }
        }
        else {
            // 背景层
            self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoLayoutFunctionBtnWidth(120), AutoLayoutFunctionBtnHeight(120))];
            self.bgView.backgroundColor = [UIColor blackColor];
            self.bgView.center = self.vc.view.center;
            self.bgView.alpha = 0.7;
            self.bgView.layer.cornerRadius = 10.0f;
            [self.vc.view addSubview:self.bgView];
            
            // 加载图效果
            CGFloat activityIndicatorViewX = self.bgView.frame.origin.x + (self.bgView.frame.size.width - 10) / 2;
            CGFloat activityIndicatorViewY = self.bgView.frame.origin.y + AutoLayoutFunctionBtnSizeY(40);
            
            self.activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(activityIndicatorViewX, activityIndicatorViewY,10,10)];
            //        CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
            //        self.activityIndicatorView.transform = transform;
            [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [self.activityIndicatorView setBackgroundColor:[UIColor clearColor]];
            [self.vc.view addSubview:self.activityIndicatorView];
            
            // 加载文字
            CGFloat textStrX = self.bgView.frame.origin.x;
            CGFloat textStrY = self.activityIndicatorView.frame.origin.y + AutoLayoutFunctionBtnSizeY(40);
            
            self.textStr = [[UILabel alloc]initWithFrame:CGRectMake(textStrX, textStrY, self.bgView.frame.size.width, 30)];
            self.textStr.text = msg;
            self.textStr.textColor = [UIColor whiteColor];
            self.textStr.textAlignment = NSTextAlignmentCenter;
            [self.vc.view addSubview:self.textStr];
            
            [self.activityIndicatorView startAnimating];
        }
    });
}

-(void)hideLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.activityIndicatorView.animating) {
            [self.bgView removeFromSuperview];
            [self.textStr removeFromSuperview];
            [self.activityIndicatorView stopAnimating];
            [self.activityIndicatorView removeFromSuperview];
        }
        else {
            
        }
    });
    
}

@end
