//
//  ViewController.m
//  Alert
//
//  Created by zw on 2020/5/19.
//  Copyright © 2020 zw. All rights reserved.
//

#import "ViewController.h"
#import "ZWAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSString *title = @"Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.Do any additional setup after loading the view.";
    
    ZWAlertController *alertVC = [ZWAlertController alertControllerWithTitle:@"提示" titleColor:nil titleFont:nil message:title messageColor:nil messageFont:nil];
    ZWAlertAction *action1 = [ZWAlertAction actionWithTitle:@"哈哈哈" font:[UIFont systemFontOfSize:14] txetColor:[UIColor redColor] handler:^(ZWAlertAction * _Nonnull action) {
        
    }];
    ZWAlertAction *action2 = [ZWAlertAction actionWithTitle:@"哈哈" font:[UIFont systemFontOfSize:14] txetColor:[UIColor blackColor] handler:^(ZWAlertAction * _Nonnull action) {
        
    }];
    ZWAlertAction *action3 = [ZWAlertAction actionWithTitle:@"嘻嘻" font:[UIFont systemFontOfSize:14] txetColor:[UIColor blueColor] handler:^(ZWAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

@end
