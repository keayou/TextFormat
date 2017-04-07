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

@end
