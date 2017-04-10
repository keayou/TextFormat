//
//  ZZResultViewController.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/3/18.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZResultViewController.h"

#import "ZZFormatEditView.h"
#import "ZZFormatEditViewController.h"
#import "ZZFormartManager.h"


@interface ZZResultViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtnNavigationBar;

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *editContainerView;


@property (strong, nonatomic) ZZFormatEditViewController *formatEditVC;
@property (strong, nonatomic) ZZFormatEditModel *curEditModel;

@end

static BOOL isEditViewShowing = NO;

@implementation ZZResultViewController
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)init{
    if ((self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZZResultViewController"])) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _editContainerView.top = self.view.bottom;

    self.editBtnNavigationBar.target = self;
    self.editBtnNavigationBar.action = @selector(showEditView:);
    

    self.titleLabel.text = _titleStr;
    self.contentLabel.text = _contentStr;
    
    ZZFormartManager *manager = [ZZFormartManager sharedInstance];
    _curEditModel = [manager fetchCustomFormartInfo];
    [self setupTitleContentFrameWithEditModel:_curEditModel];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    ZZFormartManager *manager = [ZZFormartManager sharedInstance];
    if (_curEditModel) {
        [manager saveCustomFormartInfo:_curEditModel];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WS(weakSelf);
    
    if ([segue.identifier isEqualToString:@"FormatEditView"]) {
        _formatEditVC = [segue destinationViewController];
        _formatEditVC.editCompletedBlock = ^(ZZFormatEditModel *editModel) {
            
            weakSelf.curEditModel = editModel;
            
            [weakSelf setupTitleContentFrameWithEditModel:editModel];

            [weakSelf editCompleteClick:nil];
        };
    }
}

#pragma mark - Event Response
- (void)showEditView:(UIBarButtonItem *)sender {
    
    if (isEditViewShowing) {
        return;
    }
    
    if (!_curEditModel) {
        
        _curEditModel = [ZZFormatEditModel new];
        
        _curEditModel.topMargin = self.titleLabel.top - 64;
        _curEditModel.leftMargin = self.titleLabel.left;
        _curEditModel.rightMargin = self.view.width - self.titleLabel.right;
        
        _curEditModel.titleColor = self.titleLabel.textColor;
        _curEditModel.titleFontSize = self.titleLabel.font.pointSize;
        
        
        _curEditModel.topMarginContent = self.contentLabel.top - self.titleLabel.bottom;
        _curEditModel.leftMarginContent = self.contentLabel.left;
        _curEditModel.rightMarginContent = self.view.width - self.contentLabel.right;
        _curEditModel.bottomMarginContent = self.view.height - self.contentLabel.bottom;

        _curEditModel.titleColorContent = self.contentLabel.textColor;
        _curEditModel.titleFontSizeContent = self.contentLabel.font.pointSize;
        
        _curEditModel.bgColor = self.view.backgroundColor;

    }
    
    _formatEditVC.editModel = _curEditModel;
    
    [self.view bringSubviewToFront:_editContainerView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _editContainerView.bottom = self.view.bottom;
        
    } completion:^(BOOL finished) {
        isEditViewShowing = YES;
    }];
}

- (void)editCompleteClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _editContainerView.top = self.view.bottom;
        
    } completion:^(BOOL finished) {
        isEditViewShowing = NO;

    }];
}


#pragma mark - private methos
- (void)setupTitleContentFrameWithEditModel:(ZZFormatEditModel *)editModel {
    
    if (editModel) {
        self.view.backgroundColor = editModel.bgColor;
        
        [self resetTitleFrame:editModel];
        [self resetContentFrame:editModel];
    } else {
        
        [self.titleLabel sizeToFit];
        [self.contentLabel sizeToFit];
        
        self.contentLabel.top = self.titleLabel.bottom + 20;
    }

}

- (void)resetTitleFrame:(ZZFormatEditModel *)model {
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:model.titleFontSize];
    self.titleLabel.textColor = model.titleColor;
    
    self.titleLabel.top = 64 + model.topMargin;
    self.titleLabel.right = self.view.width - model.rightMargin;
    self.titleLabel.left = model.leftMargin;

    CGFloat maxWidth = self.view.width - model.rightMargin - model.leftMargin;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setLineSpacing:model.lineMargin];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.titleLabel.font range:NSMakeRange(0, [self.titleLabel.text length])];
    [self.titleLabel setAttributedText:attributedString];

    
    CGRect titleRect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize titleSize = titleRect.size;
    self.titleLabel.height = titleSize.height;
    
    self.titleLabel.width =  maxWidth;
    
}

- (void)resetContentFrame:(ZZFormatEditModel *)model {
    
    self.contentLabel.font = [UIFont systemFontOfSize:model.titleFontSizeContent];
    self.contentLabel.textColor = model.titleColorContent;
    
    
    self.contentLabel.top = self.titleLabel.bottom + model.topMarginContent;
    self.contentLabel.left = model.leftMarginContent;
    self.contentLabel.right = self.view.width - model.rightMarginContent;
    
    self.contentLabel.width = self.view.width - model.rightMarginContent - model.leftMarginContent;
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setLineSpacing:model.lineMarginContent];

    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.contentLabel.font range:NSMakeRange(0, [self.contentLabel.text length])];
    [self.contentLabel setAttributedText:attributedString];
    
    
    CGRect titleRect = [attributedString boundingRectWithSize:CGSizeMake(self.contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize titleSize = titleRect.size;
    
    CGFloat height1 = self.view.height - model.bottomMarginContent - self.contentLabel.top;
    CGFloat height = height1 < titleSize.height ? height1 : titleSize.height;
    
    self.contentLabel.height = height;

}

#pragma mark - setters & getters
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 20 * 2, 100)];
        
//        label.layer.borderColor = [UIColor blueColor].CGColor;
//        label.layer.borderWidth = 1.0;
        
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.top = 64;
        label.left = 20;
        [self.view addSubview:label];
        _titleLabel = label;
        
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 20 * 2, 100)];
        
//        label.layer.borderColor = [UIColor redColor].CGColor;
//        label.layer.borderWidth = 1.0;
        
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.top = self.titleLabel.bottom + 20;
        label.left = 20;
        [self.view addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
    
}

@end
