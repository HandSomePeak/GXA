//
//  FunctionViewController.h
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldPage;
@property (weak, nonatomic) IBOutlet UIStepper *step;

- (IBAction)stepper:(UIStepper *)sender;
- (IBAction)Save:(UIBarButtonItem *)sender;

@end
