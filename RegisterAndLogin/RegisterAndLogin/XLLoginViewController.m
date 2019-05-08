//
//  XLLoginViewController.m
//  FMaster
//
//  Created by liu on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XLLoginViewController.h"

#import "XLRegisterViewController.h"
#import "LoadButton.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define ScreeWidth  [UIScreen mainScreen].bounds.size.width
#define ScreeHeight [UIScreen mainScreen].bounds.size.height

@interface XLLoginViewController ()

/**
 *   1.
 **/
@property (nonatomic,strong)UITextField *phoneField;

/**
 *   1.
 **/
@property (nonatomic,strong)UITextField *codeField;

/**
 *   1.
 **/
@property (nonatomic,strong)LoadButton *loginBtn;

@end

@implementation XLLoginViewController



//-(UITextField *)phoneField{
//    if (!_phoneField) {
//        _phoneField=[self setupTextfieldWithPlaceholderText:@"请输入用户名" keyboardTypeTag:4];
//        _phoneField.placeholder=@"请输入手机号";
//        _phoneField.backgroundColor=[UIColor whiteColor];
//        _phoneField.tag=1;
//    }
//    return _phoneField;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"登录";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickRegister)];
    [self setupView];
  
    
}


#pragma mark-----------2.添加输入框
-(void)setupView{

    
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.backgroundColor=[UIColor orangeColor];
   // iconView.image=[UIImage imageNamed:@"插画"];
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(158, 152));
        make.top.equalTo(self.view).offset(64+20);
        make.right.equalTo(self.view).offset(-32);
    }];
    
 
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text=@"欢迎登陆";
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:26];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
       make.top.equalTo(self.view).offset(64+50);
    }];
    
    
    UILabel *phoneLabel=[[UILabel alloc]init];
    phoneLabel.text=@"您的账号";
    phoneLabel.textColor=[UIColor blackColor];
    phoneLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(iconView.mas_bottom).offset(50);
        make.height.mas_equalTo(@40);
    }];
    
    
    UITextField *phoneField=[self setupTextfieldWithPlaceholderText:@"请输入账号" keyboardTypeTag:4];
    self.phoneField=phoneField;
    [self.view addSubview:phoneField];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(50);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@40);
    }];
    
    UIImageView *lineView=[[UIImageView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right).offset(20);
        make.top.equalTo(self.phoneField.mas_bottom).offset(1);
         make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@1);
    }];
    
    //密码
    UILabel *codeLabel=[[UILabel alloc]init];
    codeLabel.text=@"您的密码";
    codeLabel.textColor=[UIColor blackColor];
    codeLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(lineView.mas_bottom).offset(30);
        make.height.mas_equalTo(@40);
    }];
    
    
    UITextField *codeField=[self setupTextfieldWithPlaceholderText:@"请输入密码" keyboardTypeTag:3];
    codeField.backgroundColor=[UIColor whiteColor];
    codeField.tag=2;
    codeField.secureTextEntry=YES;
    // codeField.text=@"12345678";
    //  codeField.delegate=self;
    [self.view addSubview:codeField];
    self.codeField=codeField;
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeLabel.mas_right).offset(20);
        make.top.equalTo(lineView.mas_bottom).offset(30);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@40);
    }];
    
    UIImageView *lineView2=[[UIImageView alloc]init];
    lineView2.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right).offset(20);
        make.top.equalTo(self.codeField.mas_bottom).offset(1);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@1);
    }];
    
    
    UIButton *visibleBtn=[[UIButton alloc]init];
    [visibleBtn setBackgroundImage:[UIImage imageNamed:@"眼睛关"] forState:UIControlStateNormal];
    [visibleBtn setBackgroundImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateSelected];
    [visibleBtn addTarget:self action:@selector(clickCodeVisiable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visibleBtn];
    [visibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeField.mas_right).offset(15);
        make.centerY.equalTo(self.codeField);
        make.size.mas_equalTo(CGSizeMake(22, 13));
    }];
    
    //自定义一键删除按钮
//    UIButton *ClearButton = [self.codeField valueForKey:@"_clearButton"];//key值是固定的
//    [ClearButton setBackgroundImage:[UIImage imageNamed:@"jiaoliuzhongxin_xx"] forState:(UIControlStateNormal)];
//
//    UIButton *ClearButton2 = [self.phoneField valueForKey:@"_clearButton"];//key值是固定的
//    [ClearButton2 setBackgroundImage:[UIImage imageNamed:@"jiaoliuzhongxin_xx"] forState:(UIControlStateNormal)];
    
    
    
    
    //3.登录按钮
    CGFloat loginBtnY=64+20+150+90*2+30*2;
    LoadButton *loginBtn=[[LoadButton alloc]initWithFrame:CGRectMake(50, loginBtnY, ScreeWidth-100, 50)];
    loginBtn.backgroundColor=[UIColor orangeColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=25;
    loginBtn.clipsToBounds=YES;
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(cllickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn=loginBtn;
//    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(codeField.mas_bottom).offset(30);
//        make.right.equalTo(self.view).offset(-leftMargin);
//        make.size.mas_equalTo(CGSizeMake(ScreeWidth-100, 50));
//    }];
    
    //忘记密码
    UIButton *forgetBtn=[[UIButton alloc]init];
  //  forgetBtn.backgroundColor=[UIColor wh_gradientFromColor:RGBColor(68, 129, 235) toColor:RGBColor(0, 91, 234) withHeight:25 withWidth:100];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [forgetBtn addTarget:self action:@selector(cllickForget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    
    //测试
//    self.phoneField.text=@"15207972767";
//    self.codeField.text=@"123456";
    
    
}



-(UITextField *)setupTextfieldWithPlaceholderText:(NSString*)text keyboardTypeTag:(NSInteger)keyboardTypeTag{
    
    UITextField *phoneField=[[UITextField alloc]init];
    // phoneField.backgroundColor=[UIColor whiteColor];
    
    //    //设置字符往右边缩进20个单位
    //    phoneField.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
    //    phoneField.leftViewMode=UITextFieldViewModeAlways;
    
    phoneField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    
    //2.1输入框的类型
    phoneField.borderStyle=UITextBorderStyleNone;
    
    
    //2.2输入框的边框颜色
    //  phoneField.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    //2.3宽度
    //phoneField.layer.borderWidth=1;
    phoneField.placeholder=text;
    
    
    //2.4输入文字的颜色
    phoneField.textColor=[UIColor blackColor];
    
    //2.5一键删除按钮
    phoneField.clearButtonMode=UITextFieldViewModeAlways;
    
    //2.6输入款键盘的类型
    
    if (keyboardTypeTag==1) {     //字母
        phoneField.keyboardType=UIKeyboardTypeDefault;
    }else if (keyboardTypeTag==2) {     //字母汉字，数字
        phoneField.keyboardType=UIKeyboardTypeNamePhonePad;
    }else if (keyboardTypeTag==3) {     //字母汉字，数字
        phoneField.keyboardType=UIKeyboardTypeASCIICapable;
    }else if (keyboardTypeTag==4) {     //字母汉字，数字
        phoneField.keyboardType=UIKeyboardTypeNumberPad;
    }else{    //字母和号码盘
        phoneField.keyboardType=UIKeyboardTypeDefault;
    }
    
    
    //2.7设置输入框字体字号为  15
    phoneField.font=[UIFont systemFontOfSize:16];
    
    return phoneField;
    
}


//点击返回
-(void)clickBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击登录
-(void)cllickLogin{
    
    //判断手机号和密码是否正确
    if (self.phoneField.text.length!=11) {
        [SVProgressHUD showErrorWithStatus:@"请填写正确的手机号码"];
        [self shakeWithButton:self.loginBtn];
        return;
    }
    
    if (self.codeField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [self shakeWithButton:self.loginBtn];
        return;
    }
    
    [self.loginBtn beginLoading];
    
    
    //模拟网络接口请求时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.loginBtn endLoading];
        
        if (3>2) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateRootView" object:nil];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
                [self setupAnimationWithButton:self.loginBtn];
                
            });
        }
        
    
        
    });

}

//点击注册
-(void)clickRegister{
    
    XLRegisterViewController *registerView=[[XLRegisterViewController alloc]init];
    registerView.isRegister=YES;
    registerView.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:registerView animated:YES];
    
}
//点击忘记密码
-(void)cllickForget{
    
    XLRegisterViewController *registerView=[[XLRegisterViewController alloc]init];
    registerView.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:registerView animated:YES];
    
}
//点击查看明文
-(void)clickCodeVisiable:(UIButton *)button{
    button.selected=!button.selected;
    if (button.selected==YES) {
        self.codeField.secureTextEntry=NO;
    }else{
        self.codeField.secureTextEntry=YES;
    }
}


#pragma mark-----------抖动动画
-(void)setupAnimationWithButton:(UIButton *)button{
 
    CAKeyframeAnimation *keyFrame=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point=button.layer.position;
    keyFrame.values=@[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x-10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x+10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x-10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x+10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x-10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x+10, point.y)],
                      [NSValue valueWithCGPoint:point]
                      ];
    keyFrame.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration=0.5f;
    [button.layer addAnimation:keyFrame forKey:@"animation"];
    
   
}


-(void)shakeWithButton:(UIView *)button{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue= [NSValue valueWithCATransform3D:CATransform3DRotate(button.layer.transform,-0.08,0.0,0.0,0.08)];
//    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate(button.layer.transform，-0.08, 0.0, 0.0,0.08)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(button.layer.transform,0.08, 0.0, 0.0,0.08)];
    animation.duration=0.1;
    animation.repeatCount=5;
   // animation.autoreverses=YES;
    [button.layer addAnimation:animation forKey:nil];
    
}

@end
