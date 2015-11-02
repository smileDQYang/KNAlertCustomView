//
//  KNAlertCustomView.m
//  alert
//
//  Created by LuKane on 15/11/1.
//  Copyright © 2015年 LuKane. All rights reserved.
//

#import "KNAlertCustomView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ALERT_WIDTH ([UIScreen mainScreen].bounds.size.width - 50)
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define font_Normal @"Helvetica"
#define font_Bold @"Helvetica-Bold"


#define normalColor kUIColorFromRGB(0x31aeb2)
#define hightColor kUIColorFromRGB(0x25898A)

static KNAlertCustomView *sharedKNAlertView; // 全局一个变量,然后用单例生成

UIColor *_cancelBtnNormalColor;
UIColor *_cancelBtnHightColor;
UIColor *_okBtnNormalColor;
UIColor *_okBtnHightColor;
UIColor *_bgColor;

UIColor *_messageColor;
UIColor *_titleColor;

@interface KNAlertCustomView(){
    UIView *_customView;
    NSString *_okBtnString;
    NSString *_cancelBtnString;
    NSString *_title;
}

@end

@implementation KNAlertCustomView

/***************************华丽的分割线************************/
+ (void)initializeKNAlertCustBgColor:(UIColor *)bgColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor{
    _bgColor = bgColor;
    _cancelBtnNormalColor = cancelNormalColor;
    _cancelBtnHightColor = cancelHightColor;
    _okBtnNormalColor = okNormalColor;
    _okBtnHightColor = okHightColor;
}

+ (void)initializeKNAlertCustMessageColor:(UIColor *)messageColor titleColor:(UIColor *)titleColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor{
    _messageColor = messageColor;
    _titleColor = titleColor;
    
    _cancelBtnNormalColor = cancelNormalColor;
    _cancelBtnHightColor = cancelHightColor;
    
    _okBtnNormalColor = okNormalColor;
    _okBtnHightColor = okHightColor;
}

/***************************华丽的分割线************************/

- (instancetype)init{
    if(self = [super init]){
        self.rootViewController = [[KNAlertVc alloc] init];
    }
    return self;
}

// 单例 生成一个 alertView
+ (id)sharedKNAlertView{
    if(!sharedKNAlertView){
        sharedKNAlertView = [[KNAlertCustomView alloc] init];
        sharedKNAlertView.frame = (CGRect){{0.0,0.0},[[UIScreen mainScreen] bounds].size};
        sharedKNAlertView.backgroundColor = [UIColor clearColor];
        sharedKNAlertView.windowLevel = 10; // 将window等级升级到最高
    }
    return sharedKNAlertView;
}

/***************************华丽的分割线************************/

+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title okBtnString:(NSString *)okString OKBTNClick:(OKBtnBlock)okBlock{
    if(message == nil){
        return;
    }
    if(![[KNAlertCustomView sharedKNAlertView] isKeyWindow]){ // 是否是 keyWindow
        [[KNAlertCustomView sharedKNAlertView] tranformMessageToMemeberVariableTitle:title okString:okString cancelString:nil];
        [[KNAlertCustomView sharedKNAlertView] createCustomKNAlertViewMessages:@[message] hasCancelBtn:NO];
        [[KNAlertCustomView sharedKNAlertView] setOkBtnBlock:okBlock]; // 设置block
        [[KNAlertCustomView sharedKNAlertView] makeKeyAndVisible]; // 让视图可见
    }
}

+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock{
    if(message == nil){
        return;
    }
    if(![[KNAlertCustomView sharedKNAlertView] isKeyWindow]){ // 是否是 keyWindow
        [[KNAlertCustomView sharedKNAlertView] tranformMessageToMemeberVariableTitle:title okString:okString cancelString:cancelString];
        [[KNAlertCustomView sharedKNAlertView] createCustomKNAlertViewMessages:@[message] hasCancelBtn:YES];
        [[KNAlertCustomView sharedKNAlertView] setOkBtnBlock:okBlock]; // 设置block
        [[KNAlertCustomView sharedKNAlertView] setCancelBtnBlock:cancelBlock]; // 设置block
        [[KNAlertCustomView sharedKNAlertView] makeKeyAndVisible]; // 让视图可见
    }
}

+ (void)showKNALertMessages:(NSArray *)messageArr title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock{
    if(messageArr == nil || [messageArr isKindOfClass:[NSNull class]] || messageArr.count == 0){
        return ;
    }
    if(![[KNAlertCustomView sharedKNAlertView] isKeyWindow]){ // 是否是 keyWindow
        [[KNAlertCustomView sharedKNAlertView] tranformMessageToMemeberVariableTitle:title okString:okString cancelString:cancelString];
        [[KNAlertCustomView sharedKNAlertView] createCustomKNAlertViewMessages:messageArr hasCancelBtn:YES];
        [[KNAlertCustomView sharedKNAlertView] setOkBtnBlock:okBlock]; // 设置block
        [[KNAlertCustomView sharedKNAlertView] setCancelBtnBlock:cancelBlock]; // 设置block
        [[KNAlertCustomView sharedKNAlertView] makeKeyAndVisible]; // 让视图可见
    }
}

/***************************华丽的分割线************************/

// 将 传进来的信息转成 成员变量
- (void)tranformMessageToMemeberVariableTitle:(NSString *)titleText okString:(NSString *)okStringText cancelString:(NSString *)cancelStringText{
    _title = titleText;
    _okBtnString = okStringText;
    _cancelBtnString = cancelStringText;
}

// 创建自定义的 弹出框
- (void)createCustomKNAlertViewMessages:(NSArray *)messageArr hasCancelBtn:(BOOL)hasCancel{
    
// 1.设置蒙版颜色 透明度为 0.5
    [self setBackgroundColor:[UIColor blackColor]];
    self.alpha = 0.5;
    
// 2.自定义的 弹出框的背景
    // 用来 记录 弹出框的高度 :动态计算
    CGFloat CustomHeight = 0;
    
    CGFloat _customViewW = 25;
    CGFloat _customViewH = 180;
    _customView = [[UIView alloc] initWithFrame:CGRectMake(_customViewW, _customViewH, ALERT_WIDTH, ALERT_WIDTH)];
    _customView.backgroundColor = _bgColor?_bgColor:[UIColor whiteColor];
    
    // 如果输入的 title 是存在的,则创建title ,否则 则不创建 . 这是 CustomHeight 就能用上了
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, ALERT_WIDTH, 20)];
    [titleL setFont:[UIFont fontWithName:font_Bold size:18]];
    [titleL  setTextColor:_titleColor?_titleColor:kUIColorFromRGB(0x252525)];
    [titleL setText:_title?_title:@"提示"];
    [titleL setTextAlignment: NSTextAlignmentCenter];
    [_customView addSubview:titleL];
    CustomHeight = CGRectGetMaxY(titleL.frame);
    
    CustomHeight += 22; // 添加 间距
    
    UIView *messageView = [self createCustomMessageViewWithMessages:messageArr];
    [messageView setFrame:(CGRect){{messageView.frame.origin.x,CustomHeight},{messageView.frame.size.width,messageView.frame.size.height}}];
    
    [_customView addSubview:messageView];
    
// 分割线
    CustomHeight = CGRectGetMaxY(messageView.frame) + 22;
    UIView *divider = [[UIView alloc] initWithFrame:(CGRect){{0,CustomHeight},{ALERT_WIDTH,0.5}}];
    [divider setBackgroundColor:kUIColorFromRGB(0xcecece)];
    [_customView addSubview:divider];
    
    CustomHeight += 0.5; // 添加 间距
    
    CGFloat buttonH = 45;
    
    if(hasCancel == YES){ // 说明有 取消 ,则说明 下面有两个按钮
        // 分割线 2
        UIView *divider2 = [[UIView alloc] initWithFrame:CGRectMake(0.5 * ALERT_WIDTH, CustomHeight, 0.5, buttonH)];
        [divider2 setBackgroundColor:kUIColorFromRGB(0xcecece)];
        [_customView addSubview:divider2];
        
        // 取消 按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setFrame:CGRectMake(0, CGRectGetMaxY(divider.frame), ALERT_WIDTH * 0.5 , buttonH)];
        cancelBtn.tag = 2;
        [cancelBtn setTitle:_cancelBtnString?_cancelBtnString:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:_cancelBtnNormalColor?_cancelBtnNormalColor:normalColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:_cancelBtnHightColor?_cancelBtnHightColor:hightColor forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(KNAlertCustomCancelOrOkBtnIBAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:cancelBtn];
        
        // 确定 按钮
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(CGRectGetMaxX(divider2.frame), CGRectGetMaxY(divider.frame),ALERT_WIDTH / 2, buttonH)];
        okBtn.tag = 1;
        [okBtn setTitle:_okBtnString?_okBtnString:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:_okBtnNormalColor?_okBtnNormalColor:normalColor forState:UIControlStateNormal];
        [okBtn setTitleColor:_okBtnHightColor?_okBtnHightColor:hightColor forState:UIControlStateHighlighted];
        [okBtn addTarget:self action:@selector(KNAlertCustomCancelOrOkBtnIBAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:okBtn];
        
    }else{ // 说明只有一个按钮, 则为 确定 按钮
        // 确定 按钮
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, CGRectGetMaxY(divider.frame),ALERT_WIDTH, buttonH)];
        okBtn.tag = 1;
        [okBtn setTitle:_okBtnString?_okBtnString:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:_okBtnNormalColor?_okBtnNormalColor:normalColor forState:UIControlStateNormal];
        [okBtn setTitleColor:_okBtnHightColor?_okBtnHightColor:hightColor forState:UIControlStateHighlighted];
        [okBtn addTarget:self action:@selector(KNAlertCustomCancelOrOkBtnIBAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:okBtn];
    }
    
    
    CustomHeight += buttonH;
    
    _customView.layer.cornerRadius = 10;
    _customView.clipsToBounds = YES;
    [_customView setFrame:CGRectMake(_customView.frame.origin.x,(ScreenHeight - CustomHeight) * 0.5,ALERT_WIDTH ,CustomHeight)];
    [self.rootViewController.view addSubview:_customView];
}

// 创建 文本 的View
- (UIView *)createCustomMessageViewWithMessages:(NSArray *)MessageArr{
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, ALERT_WIDTH)];
    
    // 1.messageView的高度 :动态计算
    CGFloat messageViewH = 0;
    CGFloat margin = 21; // 边距

    for (NSInteger i = 0; i < MessageArr.count; i++) {
        UILabel *markL = [[UILabel alloc] initWithFrame:(CGRect){{margin,messageViewH},{30,15}}];
        
        /*
            设置 标签 ,如下所示
            1.abck
            2.sjdk
            3.slkdf
         */
        if(MessageArr.count > 1){
            [markL setTextColor:_messageColor?_messageColor:kUIColorFromRGB(0x686868)];
            [markL setFont:[UIFont systemFontOfSize:16]];
            [markL setText:[NSString stringWithFormat:@"%zd.",i + 1]];
            [markL sizeToFit];
        }else{ // 只有一条message
            markL.frame = (CGRect){{margin,0},{0,0}};
        }
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(markL.frame), messageViewH, ALERT_WIDTH - 2 * margin - 30, 15)];
        [textLabel setFont:[UIFont systemFontOfSize:16]];
        [textLabel setTextColor:_messageColor?_messageColor:kUIColorFromRGB(0x686868)];
        
        [textLabel setText:MessageArr[i]];
        [textLabel setNumberOfLines:0];

        if(MessageArr.count == 1){
            [textLabel setTextAlignment:NSTextAlignmentCenter];
            [textLabel setFont:[UIFont systemFontOfSize:17]];
        }
        
        [textLabel sizeToFit];
        
        CGRect aTextLabRect = textLabel.frame;
        aTextLabRect.size.width = ALERT_WIDTH - margin * 2 - markL.frame.size.width;
        textLabel.frame = aTextLabRect;
        
        [messageView addSubview:markL]; // 将标签添加上去
        [messageView addSubview:textLabel]; // 将文本添加上去
    
        messageViewH = CGRectGetMaxY(textLabel.frame) + 10;
    }
    
    messageViewH = messageViewH - 10;
    [messageView setFrame:(CGRect){{0,0},{ALERT_WIDTH,messageViewH}}];
    return messageView;
}

// 取消   确定 的点击
- (void)KNAlertCustomCancelOrOkBtnIBAction:(UIButton *)sender{
    
    [self KNAlertCustomViewWillClose];
    if(sender.tag == 1){ // 确定
        if(self.okBtnBlock){
            self.okBtnBlock();
        }
    }else{ // 取消
        if(self.cancelBtnBlock){
            self.cancelBtnBlock();
        }
    }
}

// 弹出框 关闭
- (void)KNAlertCustomViewWillClose{
    [_customView removeFromSuperview];
    _customView = nil;
    
    [[KNAlertCustomView sharedKNAlertView] resignKeyWindow];
    [[KNAlertCustomView sharedKNAlertView] setHidden:YES];
    sharedKNAlertView = nil;
    [[[UIApplication sharedApplication] keyWindow] setNeedsDisplay];
}

@end

@implementation KNAlertVc

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

@end

