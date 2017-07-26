//
//  ViewController.m
//  UIButtonState
//
//  Created by wangshuaipeng on 16/10/14.
//  gitHub https://github.com/spWang/UIButton-State
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+HCBState.h"
#import "ColorConfig.h"

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUPButtons];
}

- (void)setUPButtons {
    
    NSInteger Kcol = 3;
    CGFloat margin = 10;

    //多个按钮
    for (int i =0; i<11;i++) {
        UIButton *button =[self hcb_button];
        [self.view addSubview:button];
        button.tag = i;
        
        //frame
        int col = i%Kcol;
        int row = i/Kcol;
        
        CGFloat btnW = (ScreenWidth-(Kcol+1)*margin)/Kcol;
        CGFloat btnH = btnW;
        CGFloat btnX = margin +col * (margin +btnW);
        CGFloat btnY = margin + row* (margin+btnH);
        
        button.frame = CGRectMake(btnX, btnY+10, btnW, btnH);
        
        //buttonSubView
        if (i == 5) {
            UILabel *subLabel = [self hcb_label];
            [button addSubview:subLabel];
            subLabel.frame = CGRectMake(10, 10, button.bounds.size.width-20, button.bounds.size.height/3);
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //configButton
        [self configButton:button];
        
        
    }
}

- (void)configButton:(UIButton *)button {
    switch (button.tag) {
        case 0: {
            [button hcb_setBackgroundColor:color_red forState:UIControlStateNormal animated:YES];
            [button hcb_setBackgroundColor:color_skyblue forState:UIControlStateSelected animated:YES];
            [button setTitle:@"背景颜色有动画" forState:UIControlStateNormal];
            button.hcb_animatedDuration = 0.5;
        }
            break;
            
        case 1: {
            [button hcb_setBackgroundColor:color_red forState:UIControlStateNormal animated:NO];
            [button hcb_setBackgroundColor:color_skyblue forState:UIControlStateSelected animated:NO];
            [button setTitle:@"背景颜色无动画" forState:UIControlStateNormal];

        }
            break;
            
        case 2: {
            button.layer.borderWidth = 10;
            [button hcb_setborderColor:[UIColor purpleColor] forState:UIControlStateNormal animated:YES];
            [button hcb_setborderColor:color_yellow forState:UIControlStateSelected animated:YES];
            [button setTitle:@"borderColor有动画" forState:UIControlStateNormal];
        }
            break;
            
        case 3: {
            button.layer.borderWidth = 10;
            [button hcb_setborderColor:[UIColor purpleColor] forState:UIControlStateNormal animated:NO];
            [button hcb_setborderColor:color_yellow forState:UIControlStateSelected animated:NO];
            [button setTitle:@"borderColor无动画" forState:UIControlStateNormal];
        }
            break;
            
        case 4: {
            [button hcb_setTitleLabelFont:[UIFont systemFontOfSize:10] forState:UIControlStateNormal];
            [button hcb_setTitleLabelFont:[UIFont systemFontOfSize:16] forState:UIControlStateSelected];
            [button setTitle:@"标题font" forState:UIControlStateNormal];
        }
            break;
            
        case 5: {
            [button hcb_setSubViewValue:@(NSTextAlignmentLeft) forKeyPath:@"textAlignment" forState:UIControlStateNormal withSubViewTag:10001];
            [button hcb_setSubViewValue:@(NSTextAlignmentRight) forKeyPath:@"textAlignment" forState:UIControlStateSelected withSubViewTag:10001];
            [button hcb_setSubViewValue:@"子View(左)" forKeyPath:@"text" forState:UIControlStateNormal withSubViewTag:10001];
            [button hcb_setSubViewValue:@"子View(右)" forKeyPath:@"text" forState:UIControlStateSelected withSubViewTag:10001];
            [button hcb_setSubViewValue:color_skyblue forKeyPath:@"backgroundColor" forState:UIControlStateNormal withSubViewTag:10001];
            [button hcb_setSubViewValue:nil forKeyPath:@"backgroundColor" forState:UIControlStateSelected withSubViewTag:10001];
        }
            break;
        case 6: {
            button.layer.borderColor = color_red.CGColor;
            [button hcb_setborderWidth:3 forState:UIControlStateNormal animated:YES];
            [button hcb_setborderWidth:20 forState:UIControlStateSelected animated:YES];
            [button setTitle:@"borderWidth有动画" forState:UIControlStateNormal];
        }
            break;
            
        case 7: {
            button.layer.borderColor = color_red.CGColor;
            [button hcb_setborderWidth:3 forState:UIControlStateNormal animated:NO];
            [button hcb_setborderWidth:20 forState:UIControlStateSelected animated:NO];
            [button setTitle:@"borderWidth无动画" forState:UIControlStateNormal];
        }
            break;
            
        case 8: {
            [button hcb_configBackgroundColors:@{@(UIControlStateNormal) : color_red, @(UIControlStateSelected) : color_skyblue}];
            [button setTitle:@"key-value方式配置" forState:UIControlStateNormal];
        }
            break;
        
        case 9: {
            button.layer.borderWidth = 10;
            [button hcb_configBorderColors:@{@(UIControlStateNormal) : [UIColor purpleColor], @(UIControlStateSelected) : color_yellow}];
            [button setTitle:@"key-value方式配置" forState:UIControlStateNormal];
        }
            break;

        case 10: {
            [button hcb_configTitleLabelFont:@{@(UIControlStateNormal) : [UIFont systemFontOfSize:10], @(UIControlStateSelected) : [UIFont systemFontOfSize:16]}];
            [button setTitle:@"key-value方式配置" forState:UIControlStateNormal];
        }
            break;
            

        default:
            break;
    }

}

#pragma mark - action
- (void)buttonClick:(UIButton *)button {
    button.selected = !button.isSelected;
}

#pragma mark - getters and setters
- (UILabel *)hcb_label {
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = @"子View";
    lbl.font = [UIFont systemFontOfSize:10];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = color_black;
    lbl.textColor = [UIColor whiteColor];
    lbl.layer.masksToBounds = YES;
    lbl.layer.cornerRadius = 3;
    lbl.tag = 10001;
    return lbl;
}

- (UIButton *)hcb_button {
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color_lightGray;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    return button;
}


@end
