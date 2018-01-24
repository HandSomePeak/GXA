//
//  FunctionViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "FunctionViewController.h"
#import "Setting.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textFieldPage.text = [NSString stringWithFormat:@"%.0f",_step.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    _textFieldPage.text = [NSString stringWithFormat:@"%ld",[Setting sharedInstance].pageSize];
    [self.view reloadInputViews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)stepper:(UIStepper *)sender {
    _textFieldPage.text = [NSString stringWithFormat:@"%.0f",_step.value];
    
}

- (IBAction)Save:(UIBarButtonItem *)sender {
    [Setting sharedInstance].pageSize = _step.value;
}
@end
