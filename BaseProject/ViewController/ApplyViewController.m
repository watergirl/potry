//
//  ApplyViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ApplyViewController.h"
#import "UserModel.h"

#import <SMS_SDK/SMSSDK.h>
@interface ApplyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordagain;
@property (weak, nonatomic) IBOutlet UITextField *yanZhengMa;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@end

@implementation ApplyViewController
- (IBAction)apply:(id)sender {
    
    NSString *namefile = self.name.text;
    NSString *phoneNumberFile = self.phoneNumber.text;
    NSString *passwordFile = self.password.text;
    NSString *passwordagain = self.passwordagain.text;

    
    //NSArray *namearr = [UserModel name];
    NSArray *phoneNmberArr  = [UserModel phoneNumber];
    [phoneNmberArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        if ([obj isEqualToString: phoneNumberFile]) {
//            //iOS8之后  取代 alertView和actionSheet的存在
//            UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"该号码已经注册过" preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertC animated:YES completion:nil];
//            //为弹出框添加按钮
//            UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
//                NSLog(@"确认按钮被点击");
//            }];
//            //添加确认按钮到弹出框上
//            [alertC addAction:sureAction];
//            
//        }
        
         if (namefile.length==0||namefile==nil || passwordFile.length==0||namefile==nil){
            //iOS8之后  取代 alertView和actionSheet的存在
            UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertC animated:YES completion:nil];
            //为弹出框添加按钮
            UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
                NSLog(@"确认按钮被点击");
            }];
            //添加确认按钮到弹出框上
            [alertC addAction:sureAction];
        }
        else if (passwordFile!=passwordagain){
            //iOS8之后  取代 alertView和actionSheet的存在
            UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"两次密码不相同" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertC animated:YES completion:nil];
            //为弹出框添加按钮
            UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
                NSLog(@"确认按钮被点击");
            }];
            //添加确认按钮到弹出框上
            [alertC addAction:sureAction];
        }
        else {
              [UserModel updateUnderLine];          
          
//            [UserModel UpdateNameWithName:namefile password:passwordFile];
            
            
            
            //接受验证码
            [SMSSDK commitVerificationCode:self.yanZhengMa.text phoneNumber:self.phoneNumber.text zone:@"86" result:^(NSError *error) {
                if (error) {
//                    NSLog(@"验证码不正确 %@", error);
                    
                    //iOS8之后  取代 alertView和actionSheet的存在
                    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"获取验证码失败" preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [self presentViewController:alertC animated:YES completion:nil];
                    //为弹出框添加按钮
                    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
//                        NSLog(@"确认按钮被点击");
                    }];
                    //添加确认按钮到弹出框上
                    [alertC addAction:sureAction];
                }else{
                    [UserModel UpdateNameWithName:namefile password:passwordFile phoneNmber:phoneNumberFile];
                    RESideMenu *menu = [self.storyboard instantiateViewControllerWithIdentifier:@"RESideMenu"];
                    [self presentViewController:menu animated:YES completion:nil];
                }
            }];
        }
    }];
}


- (IBAction)getYanZhengMa:(id)sender {
    if (self.phoneNumber.text.length == 0 || self.phoneNumber.text == nil) {
        
        //iOS8之后  取代 alertView和actionSheet的存在
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"电话号码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertC animated:YES completion:nil];
        //为弹出框添加按钮
        UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
//            NSLog(@"确认按钮被点击");
        }];
        //添加确认按钮到弹出框上
        [alertC addAction:sureAction];
        
    }else if (self.phoneNumber.text.length != 11){
    
        //iOS8之后  取代 alertView和actionSheet的存在
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的号码" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertC animated:YES completion:nil];
        //为弹出框添加按钮
        UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
//            NSLog(@"确认按钮被点击");
        }];
        //添加确认按钮到弹出框上
        [alertC addAction:sureAction];
        
    }
    
    //  zone 国家代码  86代表中国
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }else{
            NSLog(@"验证码发送成功");
        }
    }];


}





- (void)viewDidLoad {
    [super viewDidLoad];
       // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *leftViewN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftViewN.frame = CGRectMake(0, 0, 55, 20);
    leftViewN.contentMode = UIViewContentModeCenter;
    self.name.leftView = leftViewN;
    self.name.leftViewMode = UITextFieldViewModeAlways;
   
    UIImageView *leftViewP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftViewP.frame = leftViewN.frame;
    leftViewP.contentMode = UIViewContentModeCenter;
    self.password.leftView = leftViewP;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftViewa = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftViewa.frame = leftViewN.frame;
    leftViewa.contentMode = UIViewContentModeCenter;
    
    self.passwordagain.leftView = leftViewa;
    self.passwordagain.leftViewMode = UITextFieldViewModeAlways;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancle:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)numberFile:(id)sender {
}
- (IBAction)nameFile:(id)sender {
    
    [self.password becomeFirstResponder];
}

- (IBAction)passWordFile:(id)sender {
    
    [self.passwordagain becomeFirstResponder];
}
- (IBAction)passwordagain:(id)sender {
    [self.view endEditing:YES];
}

@end
