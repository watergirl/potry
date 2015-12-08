//
//  EnterViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "EnterViewController.h"
#import "UserModel.h"
#import "LeftViewController.h"
#import "FirstViewController.h"
#import "UserModel.h"

@interface EnterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFile;
@property (weak, nonatomic) IBOutlet UITextField *passwordTexyFile;


@end

@implementation EnterViewController
- (IBAction)enter:(id)sender {
    NSString *namefile = self.nameTextFile.text;
    NSString *passwordFile = self.passwordTexyFile.text;
//    NSLog(@"%@,...%@",[UserModel passwordWithName:namefile], passwordFile);
    if ([[UserModel passwordWithName:namefile] isEqualToString:passwordFile]) {
        
        RESideMenu *menu = [self.storyboard instantiateViewControllerWithIdentifier:@"RESideMenu"];
        
        [UserModel UpdateOnlineWithName:namefile];
        
              [self presentViewController:menu animated:YES completion:nil];
    }else{
        //iOS8之后  取代 alertView和actionSheet的存在
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        //为弹出框添加按钮
        UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
            NSLog(@"确认按钮被点击");
        }];
        //添加确认按钮到弹出框上
        [alertC addAction:sureAction];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *leftViewN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftViewN.frame = CGRectMake(0, 0, 55, 20);
    leftViewN.contentMode = UIViewContentModeCenter;
    self.nameTextFile.leftView = leftViewN;
    self.nameTextFile.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *leftViewP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftViewP.frame = leftViewN.frame;
    leftViewP.contentMode = UIViewContentModeCenter;
    self.passwordTexyFile.leftView = leftViewP;
    self.passwordTexyFile.leftViewMode = UITextFieldViewModeAlways;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}



- (IBAction)naneFile:(id)sender {
    
    [self.passwordTexyFile becomeFirstResponder];
}


- (IBAction)PasswordFile:(id)sender {
    [self enter:nil];
}




@end
