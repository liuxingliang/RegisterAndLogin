//
//  ViewController.m
//  RegisterAndLogin
//
//  Created by liu on 2019/4/20.
//  Copyright © 2019 iOS . All rights reserved.
//

#import "ViewController.h"
#import "XLLoginViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"主页";
    
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:@"登录" forState:(UIControlStateNormal)];
    button.backgroundColor=[UIColor orangeColor];
    button.layer.cornerRadius=25;
    button.clipsToBounds=YES;
    [button addTarget:self action:@selector(clickButton) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame=CGRectMake((self.view.bounds.size.width-120)*0.5, 200, 120, 50);
    [self.view addSubview:button];
    
    
}


-(void)clickButton{
    
    XLLoginViewController *loginView=[[XLLoginViewController alloc]init];
    loginView.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:loginView animated:YES];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
