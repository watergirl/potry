//
//  PoetryDetailViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryDetailViewController.h"
#import "UserShi.h"
#import "UserModel.h"
@interface PoetryLastCell : UITableViewCell
@property (nonatomic,strong)FUIButton *remberbtn;
@property (nonatomic,strong)FUIButton *redBtn;

@property (nonatomic,strong)NSString *rembertitle;

@end
@implementation PoetryLastCell

-(FUIButton *)redBtn{
    if (!_redBtn) {
        _redBtn = [[FUIButton alloc]init];
        _redBtn.shadowColor = [UIColor greenSeaColor];
        _redBtn.buttonColor = [UIColor turquoiseColor];
        _redBtn.shadowHeight = 3.0f;
        _redBtn.cornerRadius = 6.0f;
       [_redBtn setTitle:@"还要再背一遍" forState:UIControlStateNormal];
        _redBtn.titleLabel.font = [UIFont boldFlatFontOfSize:20];
        [_redBtn setTitleColor:[UIColor cloudsColor] forState:0];
       [_redBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
         _redBtn.enabled = [UserShi exitusername:[UserModel nameWithOnline] shi:self.rembertitle];
       [_redBtn bk_addEventHandler:^(id sender) {
          
           _redBtn.enabled = [UserShi exitusername:[UserModel nameWithOnline] shi:self.rembertitle];
           
               [UserShi removeRemberWithUsername:[UserModel nameWithOnline] shi:self.rembertitle];
               _redBtn.enabled = NO;
               self.remberbtn.enabled = YES;
       } forControlEvents:UIControlEventTouchUpInside];
   
    }

     return _redBtn;
}

-(FUIButton *)remberbtn{
    if (!_remberbtn) {
        _remberbtn = [FUIButton buttonWithType:0];
        _remberbtn.shadowColor = [UIColor greenSeaColor];
        _remberbtn.buttonColor = [UIColor turquoiseColor];
        _remberbtn.shadowHeight = 3.0f;
        _remberbtn.cornerRadius = 6.0f;
        [_remberbtn setTitle:@"已经背过了" forState:UIControlStateNormal];
        _remberbtn.titleLabel.font = [UIFont boldFlatFontOfSize:20];
        [_remberbtn setTitleColor:[UIColor cloudsColor] forState:0];
        [_remberbtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
       
        [_remberbtn bk_addEventHandler:^(id sender) {
            if (![UserShi exitusername:[UserModel nameWithOnline] shi:self.rembertitle]) {
                    [UserShi insertusername:[UserModel nameWithOnline] shi:self.rembertitle];
                    _remberbtn.enabled = NO;
                    self.redBtn.enabled = YES;
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
  return  _remberbtn;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.remberbtn];
        [self.contentView addSubview:self.redBtn];
        
        [self.remberbtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(0);
           
            make.left.mas_equalTo(20);
        }];
        [self.redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-20);
        }];
        
    }
    return self;
}
@end


@interface PoetryDetailCell:UITableViewCell
@property(nonatomic, strong) UILabel *label;
@end
@implementation PoetryDetailCell
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:18];
//自动换行
        _label.numberOfLines = 0;
    }
    return _label;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}


@end



//右上角添加朗读诗词按钮
@interface PoetryDetailViewController ()<UITableViewDelegate, UITableViewDataSource,AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) UITableView *tableView;
//语音功能
@property(nonatomic,strong) AVSpeechSynthesizer *spe;
//右上角朗读按钮
@property(nonatomic,strong) UIBarButtonItem *readItem;
//
@end
@implementation PoetryDetailViewController

- (UIBarButtonItem *)readItem{
    if (!_readItem) {
        _readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.spe.speaking) {
                [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            AVSpeechUtterance *utt =[AVSpeechUtterance speechUtteranceWithString:_shiIntro];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
            [self.spe speakUtterance:utt];
            
        }];
    }
    return _readItem;
}

- (id)initWithShi:(NSString *)shi intro:(NSString *)shiIntro{
    if (self = [super init]) {
        _shi = shi;
        _shiIntro = shiIntro;
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView=[UIView new];
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[PoetryDetailCell class] forCellReuseIdentifier:@"DetailCell"];
        [_tableView registerClass:[PoetryLastCell class] forCellReuseIdentifier:@"LastCell"];
        
    }
    return _tableView;
}
- (AVSpeechSynthesizer *)spe{
    if (!_spe) {
        _spe = [AVSpeechSynthesizer new];
        _spe.delegate = self;
    }
    return _spe;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.title = self.shiTitle;
    self.navigationItem.rightBarButtonItem = self.readItem;
   
//    [Factory addBackItemToVC:self];
    
    
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"诗词赏析", @"注解", @"背诵情况"][section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section<2) {
        
        PoetryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        cell.label.text = @[_shi, _shiIntro][indexPath.section];
        return cell;
       
    }else{
    PoetryLastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LastCell"];
        cell.rembertitle = self.shiTitle;
   
    return cell;
    }
}

//iOS7新加入的协议
/*
 面试问题:如何提高tableView的加载速度?
 协议：HeightForRow和cellForRow 执行顺序？
 在执行cellForRow之前，table中如果有100行，那么会执行100次HeightForRow，计算出table的内容总高度，为了让右侧滑动条显示准确
 当实现estimatedHeightForRow协议以后，HeightForRow方法只会当cell加载时，才运行。
 */
//下方协议，也是通过autoLayout实现cell高度自动匹配的关键点
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return UITableViewAutomaticDimension;
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
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"停止";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}


@end
