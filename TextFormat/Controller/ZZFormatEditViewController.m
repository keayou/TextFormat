//
//  ZZFormatEditViewController.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZFormatEditViewController.h"
#import <iOS-Color-Picker/FCColorPickerViewController.h>



@interface ZZFormatEditViewController ()<UITextFieldDelegate,FCColorPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleEditScrollView;
@property (weak, nonatomic) IBOutlet UIView *titleEdgeBackView;
@property (weak, nonatomic) IBOutlet UIButton *chooseTextColorBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFontSizeTxtView;
@property (weak, nonatomic) IBOutlet UITextField *lineMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *topMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *leftMarginTxtView;
//@property (weak, nonatomic) IBOutlet UITextField *bottomMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *rightMarginTxtView;



@property (weak, nonatomic) IBOutlet UIScrollView *contentEditScrollView;
@property (weak, nonatomic) IBOutlet UIView *attributeBackView;
@property (weak, nonatomic) IBOutlet UIButton *contentChooseTextColorBtn;
@property (weak, nonatomic) IBOutlet UITextField *contentTextFontSizeTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentLineMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentTopMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentleftMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentRightTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentBottomTxtView;

@property (weak, nonatomic) IBOutlet UIView *backSetupView;
@property (weak, nonatomic) IBOutlet UIButton *backgroundColorSelectBtn;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UIButton *editSureBtn;

@end

@implementation ZZFormatEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTargetAction];
    

    [self setupTitleScrollView];
    
    _chooseTextColorBtn.layer.cornerRadius = 5.0;
    _chooseTextColorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _chooseTextColorBtn.layer.borderWidth = MIN_Scale;
    
    _contentChooseTextColorBtn.layer.cornerRadius = 5.0;
    _contentChooseTextColorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _contentChooseTextColorBtn.layer.borderWidth = MIN_Scale;
}


- (void)addTargetAction {
    [_segControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];

    [_editSureBtn addTarget:self action:@selector(editCompleteClick:) forControlEvents:UIControlEventTouchUpInside];

    [_chooseTextColorBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentChooseTextColorBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];

    [_backgroundColorSelectBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupTitleScrollView {
    _titleEditScrollView.scrollEnabled = NO;
    [_titleEditScrollView setContentSize:CGSizeMake(ScreenWidth * 3, 219)];

    NSLog(@"%f",self.view.height);
    
    [_titleEdgeBackView setFrame:CGRectMake(0, 0, ScreenWidth, 219)];
    [_attributeBackView setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 219)];
    [_backSetupView setFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, 219)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - FCColorPickerViewControllerDelegate
- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
    
    if (_segControl.selectedSegmentIndex == 0) {
        _chooseTextColorBtn.backgroundColor = color;

    } else if (_segControl.selectedSegmentIndex == 1) {
        _contentChooseTextColorBtn.backgroundColor = color;

    } else if (_segControl.selectedSegmentIndex == 2) {
        _backgroundColorSelectBtn.backgroundColor = color;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Event Response
- (void)editCompleteClick:(UIButton *)sender {
    
    ZZFormatEditModel *editModel = [[ZZFormatEditModel alloc]init];
    
    
    editModel.topMargin = [self.topMarginTxtView.text floatValue];
    editModel.leftMargin = [self.leftMarginTxtView.text floatValue];
    editModel.rightMargin = [self.rightMarginTxtView.text floatValue];
    editModel.titleColor = self.chooseTextColorBtn.backgroundColor;
    editModel.titleFontSize = [self.textFontSizeTxtView.text floatValue];
    editModel.lineMargin = [self.lineMarginTxtView.text floatValue];
    
    
    editModel.topMarginContent = [self.contentTopMarginTxtView.text floatValue];
    editModel.leftMarginContent = [self.contentleftMarginTxtView.text floatValue];
    editModel.rightMarginContent = [self.contentRightTxtView.text floatValue];
    editModel.bottomMarginContent = [self.contentBottomTxtView.text floatValue];
    editModel.titleColorContent = self.contentChooseTextColorBtn.backgroundColor;
    editModel.titleFontSizeContent = [self.contentTextFontSizeTxtView.text floatValue];
    editModel.lineMarginContent = [self.contentLineMarginTxtView.text floatValue];
    
    editModel.bgColor = self.backgroundColorSelectBtn.backgroundColor;
    
    if (_editCompletedBlock) {
        _editCompletedBlock(editModel);
    }

}

- (void)segmentControlClick:(UISegmentedControl *)seg {
    
    [_titleEditScrollView setContentOffset:CGPointMake(ScreenWidth * seg.selectedSegmentIndex, 0) animated:NO];
    
}

- (void)chooseTextColorClick:(UIButton *)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPickerWithColor:_chooseTextColorBtn.backgroundColor delegate:self];
    colorPicker.tintColor = [UIColor whiteColor];
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker
                       animated:YES
                     completion:nil];

}

#pragma mark - Setter & Getter
- (void)setEditModel:(ZZFormatEditModel *)editModel {
    if (editModel) {
        
        _editModel = editModel;
        
        self.topMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.topMargin];
        self.leftMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.leftMargin];
        self.rightMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.rightMargin];
        
        self.chooseTextColorBtn.backgroundColor = _editModel.titleColor;
        self.textFontSizeTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.titleFontSize];
        self.lineMarginTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.lineMargin];


        
        self.contentTopMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.topMarginContent];
        self.contentleftMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.leftMarginContent];
        self.contentRightTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.rightMarginContent];
        self.contentBottomTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.bottomMarginContent];

        self.contentChooseTextColorBtn.backgroundColor = _editModel.titleColorContent;
        self.contentTextFontSizeTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.titleFontSizeContent];
        self.contentLineMarginTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.lineMarginContent];
        
        self.backgroundColorSelectBtn.backgroundColor = _editModel.bgColor;

    }
}

@end
