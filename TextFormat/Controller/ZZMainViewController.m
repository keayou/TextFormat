//
//  ZZMainViewController.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/3/18.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZMainViewController.h"
#import "ZZResultViewController.h"

@interface ZZMainViewController ()
@property (weak, nonatomic) IBOutlet UITextView *titleTxtView;
@property (weak, nonatomic) IBOutlet UITextView *contentTxtView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

@end

@implementation ZZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nextBtn.target = self;
    self.nextBtn.action = @selector(naviDoneClick:);
    
//    self.titleTxtView.layer.borderColor = [UIColor blueColor].CGColor;
//    self.titleTxtView.layer.borderWidth = MIN_Scale;
    [self setupTextViewWith:_titleTxtView placeholder:@"请输入标题"];
    self.titleTxtView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);


//    self.contentTxtView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.contentTxtView.layer.borderWidth = MIN_Scale;
    [self setupTextViewWith:_contentTxtView placeholder:@"请输入正文"];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
- (void)naviDoneClick:(UIButton *)sender {
    
    ZZResultViewController *resultVC = [[ZZResultViewController alloc] init];
    
    resultVC.titleStr = self.titleTxtView.text;
    resultVC.contentStr = self.contentTxtView.text;
    
    [self.navigationController pushViewController:resultVC animated:YES];
    
}

- (void)setupTextViewWith:(UITextView *)txtView placeholder:(NSString *)placeholder
{
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 1;
    placeHolderLabel.textColor = [UIColor colorWithHex:@"ded7d7"];
    
    // same font
    placeHolderLabel.font = txtView.font;
    [placeHolderLabel sizeToFit];
    [txtView addSubview:placeHolderLabel];

    [txtView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
};

//
//- (UITextView *)titleTxtView {
//    
//    if (!_titleTxtView) {
//        UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(18, 64 + 23, ScreenWidth - 18 * 2, 400)];
//        txtView.textColor = [UIColor colorWithHex:@"333333"];
//        txtView.font = [UIFont systemFontOfSize:20];
//        [self setupTextViewWith:txtView placeholder:@"请输入标题"];
//        [self.view addSubview:txtView];
//        _titleTxtView = txtView;
//    }
//    return _titleTxtView;
//}
//
//- (UITextView *)contentTxtView {
//    
//    if (!_contentTxtView) {
//        UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.titleTxtView.frame) + 28, ScreenWidth - 18 * 2, ScreenHeight - CGRectGetMaxY(self.titleTxtView.frame) - 28 )];
//        txtView.textColor = [UIColor colorWithHex:@"333333"];
//        txtView.font = [UIFont systemFontOfSize:20];
//        [self setupTextViewWith:txtView placeholder:@"请输入标题"];
//        [self.view addSubview:txtView];
//        _contentTxtView = txtView;
//    }
//    return _contentTxtView;
//}

@end
