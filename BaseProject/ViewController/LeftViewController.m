//
//  LeftViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LeftViewController.h"
#import "kImageView.h"
#import "UserModel.h"
#import "EnterViewController.h"
#import "RemberShiViewController.h"
#import "ChangePageViewController.h"
#import "AboutViewController.h"
#import "UserPlan.h"

#import "MyPlaytabBarcontroller.h"

@interface FirstCell : UITableViewCell
@property (nonatomic,strong)kImageView *imageview;
//@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *encourage;
@end
@implementation FirstCell

-(kImageView *)imageview{
    if (!_imageview) {
        _imageview =[kImageView new];
        //变圆
        _imageview.layer.cornerRadius = 60/2;
        
    }
    return _imageview;
}
-(UILabel *)name{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont boldFlatFontOfSize:20];
        _name.textColor = [UIColor blackColor];
    }
    return _name;
}
-(UILabel *)encourage{
    if (!_encourage) {
        _encourage = [UILabel new];
        _encourage.font = [UIFont systemFontOfSize:15];
        _encourage.textColor = [UIColor grayColor];
        _encourage.text = @"欲带皇冠,必承其重";
        _encourage.numberOfLines = 0;
        _encourage.textColor = [UIColor blackColor];
    }
    _encourage.numberOfLines=0;
    return _encourage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.encourage];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.imageview];
        
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageview.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(5);
            
        }];
        [self.encourage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageview.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self.name.mas_bottom).mas_equalTo(10);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
    }
    return self;
}
@end

@interface SecondCell : UITableViewCell
@property (nonatomic,strong)kImageView *imageview;
@property (nonatomic,strong)UILabel *imageLb;
@end
@implementation SecondCell
-(kImageView *)imageview{
    if (!_imageview) {
        _imageview = [[kImageView alloc]init];
    }
    return _imageview;
}
-(UILabel *)imageLb{
    if (!_imageLb) {
        _imageLb = [[UILabel alloc]init];
        _imageLb.font = [UIFont systemFontOfSize:18];
        _imageLb.textColor = [UIColor whiteColor];
    }
    return _imageLb;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageLb];
        [self.contentView addSubview:self.imageview];
        
        [self.imageLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageview.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
        
        
    }
    
    return self;
}
@end

@interface ThirdCell : UITableViewCell
@property (nonatomic,strong)UIButton *btn;

@end
@implementation ThirdCell
-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"退出登录" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:25];
        [_btn setFrame:CGRectMake(0, 0, 200, 60)];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
    }
    return _btn;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(30);
            
        }];
        
        
        
    }
    return self;
}
@end


@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ChangePageViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *itemNames;
@property (nonatomic,strong)NSArray *itemImage;
@property (nonatomic,strong)UIImage *headpicture;
//本地地址用来存储图片
@property(nonatomic,strong) NSString *directoryPath;
@end

@implementation LeftViewController

-(NSString *)directoryPath{
    if (!_directoryPath) {
        //  /documents/images
        NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _directoryPath=[docPath stringByAppendingPathComponent:@"images"];
        NSFileManager *manager=[NSFileManager defaultManager];
        if (![manager fileExistsAtPath:_directoryPath]) {
            [manager createDirectoryAtPath:_directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _directoryPath;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[FirstCell class] forCellReuseIdentifier:@"fcell"];
        [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"scell"];
        [_tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"tcell"];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kWindowW*2/3, kWindowH*2/3));
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemNames.count+2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fcell"];
        cell.name.text = [UserModel nameWithOnline];
       
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
         NSString *filePath=[self.directoryPath stringByAppendingPathComponent:@"image"];
        NSFileManager *manager=[NSFileManager defaultManager];
        if ([manager fileExistsAtPath:filePath]) {
           
            UIImage *exitimage=[UIImage imageWithContentsOfFile:filePath];
        
            self.headpicture=exitimage;
        }
//        NSData *data = UIImagePNGRepresentation(self.headpicture);
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//      NSURL *url =  [NSURL URLWithString:str];
//        [cell.imageview.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"coolStart_retired_n"]];
        
        if (self.headpicture) {
            cell.imageview.imageView.image = self.headpicture ;

        }else{
            cell.imageview.imageView.image = [UIImage imageNamed:@"coolStart_retired_n"];

        }
        
      
        return cell;
    }if (indexPath.row==5) {
        
        ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tcell"];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        [cell.btn bk_addEventHandler:^(id sender) {
            
            [UserModel updateUnderLine];
           EnterViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"EnterViewController"];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        
        SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scell"];
        cell.imageLb.text = self.itemNames[indexPath.row-1];
        NSString *imagename = self.itemImage[indexPath.row-1];
        cell.imageview.imageView.image = [UIImage imageNamed:imagename];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 70;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        ChangePageViewController *vc = [ChangePageViewController new];
         vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
    if (indexPath.row==1) {
        
        UIImagePickerController *pc = [UIImagePickerController new];
        pc.delegate = self;
        [self presentViewController:pc animated:YES completion:nil];
        
    }
    
    if (indexPath.row==2) {
         RemberShiViewController *vc =  [RemberShiViewController new];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
       
        [self presentViewController:navc animated:YES completion:nil];
        
    }
    if (indexPath.row==3) {
        AboutViewController *vc = [AboutViewController new];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
    }
    if (indexPath.row==4) {
      
        MyPlaytabBarcontroller *vc = [MyPlaytabBarcontroller new];
        NSLog(@"1");
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        NSLog(@"2");
        [self presentViewController:navi animated:YES completion:nil];
    
    }
    
    


}

#pragma mark ChangeDelegate
-(void)change:(ChangePageViewController *)changeVC didInPutImage:(UIImage *)image{
   

    NSString *filePath=[self.directoryPath stringByAppendingPathComponent:@"image"];
   
   
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:filePath atomically:YES];
    
    self.headpicture = image;
    
    
    
    [self.tableView reloadData];
  
}


kRemoveCellSeparator
- (NSArray *)itemNames {
	if(_itemNames == nil) {
		_itemNames = @[@"我的相册",@"我的收藏",@"关于软件",@"我的计划"];
	}
	return _itemNames;
}

- (NSArray *)itemImage {
	if(_itemImage == nil) {
		_itemImage = @[@"MyAlbum",@"MyFavorites",@"Setting",@"MyBankCard"];
	}
	return _itemImage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
 
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
