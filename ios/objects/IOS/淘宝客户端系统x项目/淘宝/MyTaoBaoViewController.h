//
//  MyTaoBaoViewController.h
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaoBaoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TextFileUserName;
@property (weak, nonatomic) IBOutlet UITextField *TextFilePassworld;
- (IBAction)buttonLogin:(UIButton *)sender;
- (IBAction)return1:(UITextField *)sender;
- (IBAction)return2:(UITextField *)sender;
- (IBAction)button:(UIButton *)sender;

@end