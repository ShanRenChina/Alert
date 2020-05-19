//
//  ZWAlertController.m
//  Alert
//
//  Created by zw on 2020/5/19.
//  Copyright © 2020 zw. All rights reserved.
//

#import "ZWAlertController.h"

@interface ZWAlertAction ()

/** button */
@property (strong, nonatomic) UIButton * button;
@property (nonatomic, copy) void(^actionHandler)(ZWAlertAction *action);

@end

@implementation ZWAlertAction

+ (instancetype)actionWithTitle:(nullable NSString *)title font:(UIFont *)font txetColor:(UIColor *)color handler:(void (^ __nullable)(ZWAlertAction *))handler
{
    ZWAlertAction *instance = [ZWAlertAction new];
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender setTitle:title forState:0];
    [sender setTitleColor:color forState:0];
    sender.titleLabel.font = font;
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];
    [sender addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    instance.button = sender;
    
    instance.actionHandler = handler;
    return instance;
}

@end


@interface ZWAlertController ()

/** 标题 */
@property (nonatomic, copy) NSString   * titleStr;
/** 内容 */
@property (nonatomic, copy) NSString   * message;
/** 标题颜色 */
@property (strong, nonatomic) UIColor  * titleColor;
/** 标题font */
@property (strong, nonatomic) UIFont   * titleFont;
/** 内容颜色 */
@property (strong, nonatomic) UIColor  * contentColor;
/** 内容font */
@property (strong, nonatomic) UIFont   * contentFont;

/** alert action */
@property (nonatomic, strong) NSMutableArray   * mutableActions;

/* title lab **/
@property (nonatomic, strong) UILabel   * titleLab;
/* text view **/
@property (nonatomic, strong) UILabel   * contentLab;

/* view **/
@property (nonatomic, strong) UIView    * contentView;



@end

@implementation ZWAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(UIColor *)tColor titleFont:(UIFont *)tFont message:(NSString *)message messageColor:(UIColor *)mColor messageFont:(UIFont *)mFont{
    
    ZWAlertController *instance = [[ZWAlertController alloc]init];
    instance.titleStr     = title;
    instance.titleColor   = tColor;
    instance.titleFont    = tFont;
    instance.message      = message;
    instance.contentColor = mColor;
    instance.contentFont  = mFont;
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.titleLab.text = self.titleStr;
    
    /** 创建基础视图 */
    [self creatContentView];
    
    /** 创建按钮 */
    [self creatAllButtons];
    
    /** 设置弹出框的frame */
    [self configContentViewFrame];

}

- (NSMutableArray *)mutableActions
{
    if (!_mutableActions) {
        _mutableActions = [NSMutableArray array];
    }
    return _mutableActions;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = self.titleFont == nil? [UIFont systemFontOfSize:18] : self.titleFont;
        _titleLab.textColor = self.titleColor == nil? [self colorHexString:@"333333"] : self.titleColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = self.contentFont == nil? [UIFont systemFontOfSize:14]:self.contentFont;
        _contentLab.textColor = self.contentColor == nil? [self colorHexString:@"333333"] : self.contentColor;
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}


- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (void)addAction:(ZWAlertAction *)action{
    [self.mutableActions addObject:action];
}


- (void)creatContentView{
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)creatAllButtons{

    for (int i=0; i<self.mutableActions.count; i++) {
        ZWAlertAction *action = self.mutableActions[i];
        action.button.tag = i;
        [action.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:action.button];
        
        if (self.mutableActions.count==2) {
            [action.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(i==0?0:135);
                make.size.mas_equalTo(CGSizeMake(134.5, 45));
                make.bottom.mas_equalTo(0);
            }];
            if (i==0) {
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];
                [self.contentView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(action.button.mas_right).offset(0);
                    make.height.mas_equalTo(45);
                    make.width.mas_equalTo(0.5);
                    make.bottom.mas_equalTo(0);
                }];
            }

        }else{
            
            CGFloat top = (self.mutableActions.count-(i+1))*45;
            [action.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(45);
                make.bottom.mas_offset(-top);
            }];
            
        }

    }
    
    
}

- (void)buttonAction:(UIButton *)sender{
    
    ZWAlertAction *action = self.mutableActions[sender.tag];
    action.actionHandler(action);
    [self showDisappearAnimation];
}

- (void)showDisappearAnimation
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configContentViewFrame{
    
    self.contentLab.text = self.message;
    
    CGFloat StatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat TopHeight       = StatusBarHeight + 44.0;
    CGFloat TabBarHeight    = (StatusBarHeight>20.0? 83.0:49.0 );
    CGFloat ScreenHeight    = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat contentHeight = [self heightWithFont:[UIFont systemFontOfSize:14]];
    CGFloat height = contentHeight + 16 + 50 + (self.mutableActions.count==2?45:self.mutableActions.count*45);
    height = height>=(ScreenHeight-TopHeight-TabBarHeight)?(ScreenHeight-TopHeight-TabBarHeight):height;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(height);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
    }];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    /** 显示弹出动画 */
    [self showAppearAnimation];
}

- (void)showAppearAnimation
{
    self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self.mutableActions.count==0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showDisappearAnimation];
            });
        }
    }];
}


/**
 *  获取颜色
 */
- (UIColor *)colorHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat red, blue, green;
    
    red   = [self colorComponentFrom: colorString start: 0 length: 2];
    green = [self colorComponentFrom: colorString start: 2 length: 2];
    blue  = [self colorComponentFrom: colorString start: 4 length: 2];
        
    return [UIColor colorWithRed: red green: green blue: blue alpha: 1];
}

- (CGFloat)colorComponentFrom:(NSString *)string
                       start:(NSUInteger)start
                      length: (NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (CGFloat)heightWithFont:(UIFont *)font{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:font forKey:NSFontAttributeName];
    CGRect rect = [self.message boundingRectWithSize:CGSizeMake(270-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    //此处要使用ceil函数 大于或等于的最小整数
    CGFloat height = ceil(CGRectGetHeight(rect));

    return height;
}

@end
