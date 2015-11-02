# KNAlertCustomView

*1.提供自定义弹出框,类似于AlertView 或 AlertController

*2.自定义 弹出框的背景颜色,字体颜色,高亮和正常的按钮颜色

*3.实现于UIWindow上的普通View

*4.输入一行提示文字,提示信息,确定按钮的文字.
+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title okBtnString:(NSString *)okString OKBTNClick:(OKBtnBlock)okBlock;

*5.输入一行提示文字,提示信息,确定和取消文字.
+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock;

*6.输入多行提示文字,以数组的形式保存进去,取消和确定文字
+ (void)showKNALertMessages:(NSArray *)messageArr title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock;

*7.初始化背景颜色,取消和确定的normal和高亮颜色
+ (void)initializeKNAlertCustBgColor:(UIColor *)bgColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor ;

*8.初始化提示消息的颜色,提示的颜色,取消和确定的normal和高亮的颜色
+ (void)initializeKNAlertCustMessageColor:(UIColor *)messageColor titleColor:(UIColor *)titleColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor;

*9.注意:若想设置颜色,则先调用initialize...方法,再去执行 弹出框方法

