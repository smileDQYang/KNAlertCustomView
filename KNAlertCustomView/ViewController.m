//
//  ViewController.m
//  KNAlertCustomView
//
//  Created by LUKHA_Lu on 15/11/2.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "ViewController.h"
#import "KNAlertCustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我有用" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click{
    // 1.若需要自定义颜色,则先调用下面
    
    // 方式1:
    [KNAlertCustomView initializeKNAlertCustBgColor:nil cancelBtnColor:[UIColor greenColor] cancelHightColor:[UIColor blueColor] okBtnColor:nil okHightColor:[UIColor blueColor]];
    
    // 方式2:
    [KNAlertCustomView initializeKNAlertCustMessageColor:[UIColor redColor] titleColor:nil cancelBtnColor:[UIColor blueColor] cancelHightColor:nil okBtnColor:[UIColor blueColor] okHightColor:nil];
    
    // 2.弹出框 开始
    // 方式1:
    [KNAlertCustomView showKNAlertMessage:@"你好" title:nil cancelBtnString:nil okBtnString:nil cancelBTNClick:^{
        NSLog(@"cancel");
    } okBTNClick:^{
        NSLog(@"ok");
    }];
    
    // 方式2:
    [KNAlertCustomView showKNAlertMessage:@"您好" title:@"随便说说" okBtnString:@"开始" OKBTNClick:^{
        NSLog(@"开始咯~");
    }];
    
    // 方式3:
    [KNAlertCustomView showKNALertMessages:@[@"你好啊",@"您好啊",@"您挺好"] title:@"多行消息" cancelBtnString:@"取消咯" okBtnString:@"确定吧" cancelBTNClick:^{
        NSLog(@"取消");
    } okBTNClick:^{
        NSLog(@"确定");
    }];
}

@end
