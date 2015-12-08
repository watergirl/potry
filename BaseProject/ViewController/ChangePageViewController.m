//
//  ChangePageViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ChangePageViewController.h"

@interface ChangePageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UILabel *Ltitle;
@property (nonatomic,strong)FUIButton *btnCamare;
@property (nonatomic,strong)FUIButton *btnSystem;
@property (nonatomic,strong)FUIButton *btnCancle;
@property (nonatomic,strong)FUIButton *btnOK;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImage *image;
@end

@implementation ChangePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *witeView = [UIView new];
    witeView.backgroundColor = [UIColor purpleColor];
    witeView.alpha = 0.7;
    [self.view addSubview:witeView];
    [witeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(self.view.frame.size.height/3);
        make.bottom.mas_equalTo(0);
    }];
     [witeView addSubview:self.Ltitle];
     [witeView addSubview:self.btnCamare];
     [witeView addSubview:self.btnSystem];
     [witeView addSubview:self.btnCancle];
     [witeView addSubview:self.btnOK];
    
    [self.Ltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    [self.btnSystem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.Ltitle.mas_bottom).mas_equalTo(5);
        
    }];
    [self.btnCamare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.btnSystem.mas_bottom).mas_equalTo(5);
        
    }];
    [self.btnCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.btnCamare.mas_bottom).mas_equalTo(5);
        
    }];
    [self.btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.btnCancle.mas_bottom).mas_equalTo(5);
        
    }];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(self.imageView.mas_width);
        
    }];
    
}
-(UILabel *)Ltitle{
    if (!_Ltitle) {
        _Ltitle = [UILabel new];
        _Ltitle.textAlignment = NSTextAlignmentCenter;
        _Ltitle.text = @"更换头像";
    }
    return _Ltitle;
}
-(FUIButton *)btnCamare{
    if (!_btnCamare) {
        _btnCamare = [FUIButton buttonWithType:0];
        [_btnCamare setTitle:@"拍照" forState:UIControlStateNormal];
        [_btnCamare bk_addEventHandler:^(id sender) {
           
            UIImagePickerController *pc = [UIImagePickerController new];
            pc.delegate = self;
            //开启编辑功能
            pc.allowsEditing = YES;
//            //选取图片类型
            pc.mediaTypes = @[(NSString *)kUTTypeImage];
//            //输入源选择默认是相册
            pc.sourceType = UIImagePickerControllerSourceTypeCamera;
//
            [self presentViewController:pc animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCamare;
}

-(FUIButton *)btnSystem{
    if (!_btnSystem) {
        _btnSystem = [FUIButton buttonWithType:0];
        [_btnSystem setTitle:@"从相册中选取" forState:UIControlStateNormal];
        [_btnSystem bk_addEventHandler:^(id sender) {
            UIImagePickerController *pc = [UIImagePickerController new];
            pc.delegate = self;
            pc.allowsEditing = YES;
            [self presentViewController:pc animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSystem;
}
-(FUIButton *)btnCancle{
    if (!_btnCancle) {
        _btnCancle = [FUIButton buttonWithType:0];
        
        [_btnCancle setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancle bk_addEventHandler:^(id sender) {
            [self dismissModalViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancle;
}

-(FUIButton *)btnOK{
    if (!_btnOK) {
        _btnOK = [FUIButton buttonWithType:0];
        [_btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [_btnOK bk_addEventHandler:^(id sender) {
           
            [self.delegate change:self didInPutImage:self.image];
            
            [self dismissModalViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnOK;
}

- (UIImageView *)imageView {
	if(_imageView == nil) {
		_imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
	}
	return _imageView;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//  _image View.image = image;
  // 获取编辑后的照片
   image = info[UIImagePickerControllerEditedImage];
    _imageView.image = image;
    self.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
