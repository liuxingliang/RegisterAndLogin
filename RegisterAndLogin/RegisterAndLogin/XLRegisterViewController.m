//
//  XLRegisterViewController.m
//  FMaster
//
//  Created by liu on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XLRegisterViewController.h"

#import "XLGCDTimer.h"
#import "LoadButton.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define ScreeWidth  [UIScreen mainScreen].bounds.size.width
#define ScreeHeight [UIScreen mainScreen].bounds.size.height
@interface XLRegisterViewController ()

@property (nonatomic,strong)UITextField *phoneField;

@property (nonatomic,strong)UITextField *codeField;

@property (nonatomic,strong)UITextField *pwdField;

@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UITextField *confirmPwdField;
/**
 *     4.计时器
 */
@property (nonatomic, strong)XLGCDTimer *timer;
/**
 *   1.
 **/
@property (nonatomic,strong)UIButton *grabCodeBtn;
/**
 *   1.
 **/
@property (nonatomic,strong)LoadButton *loginBtn;
@end

@implementation XLRegisterViewController
-(XLGCDTimer *)timer{
    if (!_timer) {
        _timer=[[XLGCDTimer alloc]init];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self setupView];
    
    
}


#pragma mark-----------2.添加输入框
-(void)setupView{
    
    
    UIImageView *iconView=[[UIImageView alloc]init];
    // iconView.backgroundColor=[UIColor orangeColor];
    iconView.image=[UIImage imageNamed:@"插画"];
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(158, 152));
        make.top.equalTo(self.view).offset(64+20);
        make.right.equalTo(self.view).offset(-32);
    }];
    
    
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text=self.isRegister?@"欢迎注册":@"忘记密码";
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:26];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.top.equalTo(self.view).offset(64+50);
    }];
    
    
    NSMutableArray *titleArray=[NSMutableArray array];
    if (self.isRegister==YES) {
        titleArray=[NSMutableArray arrayWithObjects:@"手机号码",@"短信验证",@"设置密码",@"确认密码", nil];
    }else{
        titleArray=[NSMutableArray arrayWithObjects:@"手机号码",@"短信验证",@"新密码",@"确认密码", nil];
    }
    
    for ( int i=0; i<titleArray.count; i++) {
        //1.提示文字
        UILabel *phoneLabel=[[UILabel alloc]init];
        phoneLabel.text=titleArray[i];
        phoneLabel.textColor=[UIColor blackColor];
        phoneLabel.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:phoneLabel];
        self.phoneLabel=phoneLabel;
        CGFloat phoneLableY=(40+30)*i;
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(50);
            make.top.equalTo(iconView.mas_bottom).offset(50+phoneLableY);
            make.height.mas_equalTo(@40);
        }];
        //2.线条
        UIImageView *lineView=[[UIImageView alloc]init];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [self.view addSubview:lineView];
        CGFloat lineViewY=(40+1+30)*i+40+50;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneLabel.mas_right).offset(20);
            make.top.equalTo(iconView.mas_bottom).offset(lineViewY);
            make.width.mas_equalTo(ScreeWidth-50-60-30-50);
            make.height.mas_equalTo(@1);
        }];
    }
    
    UITextField *phoneField=[self setupTextfieldWithPlaceholderText:@"请输入手机号" keyboardTypeTag:4];
    self.phoneField=phoneField;
    [self.view addSubview:phoneField];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.left.equalTo(self.view).offset(50+80+15);
         make.left.equalTo(self.phoneLabel.mas_right).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(50+70*0);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@40);
    }];
    
    
    
    //验证码
    UITextField *codeField=[self setupTextfieldWithPlaceholderText:@"请输入验证码" keyboardTypeTag:3];
    codeField.backgroundColor=[UIColor whiteColor];
    codeField.tag=2;
    // codeField.text=@"12345678";
    //  codeField.delegate=self;
    [self.view addSubview:codeField];
    self.codeField=codeField;
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(50+70*1);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50-80+15);
        make.height.mas_equalTo(@40);
    }];
    
    //密码
    UITextField *pwdField=[self setupTextfieldWithPlaceholderText:@"6~16位字母数字" keyboardTypeTag:3];
    pwdField.backgroundColor=[UIColor whiteColor];
    pwdField.tag=2;
     pwdField.secureTextEntry=YES;
    // codeField.text=@"12345678";
    //  codeField.delegate=self;
    [self.view addSubview:pwdField];
    self.pwdField=pwdField;
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(50+70*2);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@40);
    }];
    
    //确认密码
    UITextField *confirmPwdField=[self setupTextfieldWithPlaceholderText:@"6~16位字母数字" keyboardTypeTag:3];
    confirmPwdField.backgroundColor=[UIColor whiteColor];
    confirmPwdField.tag=3;
     confirmPwdField.secureTextEntry=YES;
    // codeField.text=@"12345678";
    //  codeField.delegate=self;
    [self.view addSubview:confirmPwdField];
    self.confirmPwdField=confirmPwdField;
    [self.confirmPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(50+70*3);
        make.width.mas_equalTo(ScreeWidth-50-60-30-50);
        make.height.mas_equalTo(@40);
    }];
    
    //2.2获取验证码按钮
    UIButton *grabCodeBtn=[[UIButton alloc]init];
    grabCodeBtn.tag=1;
    grabCodeBtn.backgroundColor=[UIColor whiteColor];
    [grabCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [grabCodeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    grabCodeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [grabCodeBtn addTarget:self action:@selector(cllickPostCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:grabCodeBtn];
    [grabCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeField.mas_right).offset(0);
        make.top.equalTo(iconView.mas_bottom).offset(50+70*1);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(@40);
    }];
    self.grabCodeBtn=grabCodeBtn;
    
    for (int i=0; i<2; i++) {
        UIButton *visibleBtn=[[UIButton alloc]init];
        visibleBtn.tag=i;
        [visibleBtn setBackgroundImage:[UIImage imageNamed:@"眼睛关"] forState:UIControlStateNormal];
        [visibleBtn setBackgroundImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateSelected];
        [visibleBtn addTarget:self action:@selector(clickCodeVisiable:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:visibleBtn];
        if (i==0) {
            [visibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.pwdField.mas_right).offset(15);
                make.centerY.equalTo(self.pwdField);
                make.size.mas_equalTo(CGSizeMake(22, 13));
                
            }];
        }else{
            [visibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.confirmPwdField.mas_right).offset(15);
                make.centerY.equalTo(self.confirmPwdField);
                make.size.mas_equalTo(CGSizeMake(22, 13));
                
            }];
        }
       
    }
   
    
    //自定义一键删除按钮
    //    UIButton *ClearButton = [self.codeField valueForKey:@"_clearButton"];//key值是固定的
    //    [ClearButton setBackgroundImage:[UIImage imageNamed:@"jiaoliuzhongxin_xx"] forState:(UIControlStateNormal)];
    //
    //    UIButton *ClearButton2 = [self.phoneField valueForKey:@"_clearButton"];//key值是固定的
    //    [ClearButton2 setBackgroundImage:[UIImage imageNamed:@"jiaoliuzhongxin_xx"] forState:(UIControlStateNormal)];
    
    
    
    
    //3.登录按钮
    CGFloat loginBtnY=64+20+150+50+70*4;
     LoadButton *loginBtn=[[LoadButton alloc]initWithFrame:CGRectMake(50, loginBtnY, ScreeWidth-100, 50)];
    loginBtn.tag=0;
    loginBtn.backgroundColor=[UIColor orangeColor];
    NSString *string=self.isRegister?@"注册账户":@"确认修改";
    [loginBtn setTitle:string forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=25;
    loginBtn.clipsToBounds=YES;
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(cllickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn=loginBtn;
//    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(confirmPwdField.mas_bottom).offset(30);
//        make.right.equalTo(self.view).offset(-leftMargin);
//        make.size.mas_equalTo(CGSizeMake(ScreeWidth-100, 50));
//    }];
    

    
    
    
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
    phoneField.textColor=[UIColor blackColor];;
    
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
    phoneField.font=[UIFont systemFontOfSize:14];
    
    return phoneField;
    
}

#pragma mark------------点击事件
-(void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cllickPostCode{
    
    //判断手机号是否正确
    if (self.phoneField.text.length!=11) {
        [SVProgressHUD showErrorWithStatus:@"请填写正确的手机号"];
        return;
    }
    NSLog(@"点击获取验证码");

    
    [self.timer startButton:self.grabCodeBtn Time:59 title:@" " waitTittle:@"重新发送" backColor:[UIColor whiteColor] textColor:[UIColor blackColor]];
    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
   
    
}
//点击查看明文
-(void)clickCodeVisiable:(UIButton *)button{
    
    button.selected=!button.selected;
    
    if (button.selected==YES) {
        if (button.tag==0) {
            self.pwdField.secureTextEntry=NO;
        }else{
            self.confirmPwdField.secureTextEntry=NO;
        }
    }else{
        if (button.tag==0) {
            self.pwdField.secureTextEntry=YES;
        }else{
            self.confirmPwdField.secureTextEntry=YES;
        }
    }
}

//点击注册
-(void)cllickRegister{
    if (self.phoneField.text.length!=11) {
        [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号"];
          [self shakeWithButton:self.loginBtn];
        return;
    }
    if (self.codeField.text.length!=5) {
        [SVProgressHUD showInfoWithStatus:@"请填写正确的验证码"];
          [self shakeWithButton:self.loginBtn];
        return;
    }
    if (![self.pwdField.text isEqualToString:self.confirmPwdField.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码填写不一致哦"];
          [self shakeWithButton:self.loginBtn];
        return;
    }
    if (self.pwdField.text.length<6||self.pwdField.text.length>16) {
        [SVProgressHUD showInfoWithStatus:@"请输入6~16位字母数字的密码"];
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
                      [NSValue valueWithCGPoint:CGPointMake(point.x-10, point.y)],
                      [NSValue valueWithCGPoint:CGPointMake(point.x+10, point.y)],
                      [NSValue valueWithCGPoint:point]
                      ];
    keyFrame.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration=0.8f;
    [button.layer addAnimation:keyFrame forKey:@"animation"];
    
    
}

-(void)shakeWithButton:(UIButton *)button{
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
