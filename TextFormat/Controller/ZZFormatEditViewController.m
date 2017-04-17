//
//  ZZFormatEditViewController.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZFormatEditViewController.h"
#import <iOS-Color-Picker/FCColorPickerViewController.h>
#import "NSString+ZZHexColor.h"



@interface ZZFormatEditViewController ()<UITextFieldDelegate,FCColorPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (weak, nonatomic) IBOutlet UIView *titleEdgeBackView;
@property (weak, nonatomic) IBOutlet UIButton *chooseTextColorBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFontSizeTxtView;
@property (weak, nonatomic) IBOutlet UITextField *lineMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *topMarginTxtView;
//@property (weak, nonatomic) IBOutlet UITextField *leftMarginTxtView;
//@property (weak, nonatomic) IBOutlet UITextField *bottomMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *edgeMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *titleColor;



@property (weak, nonatomic) IBOutlet UIView *attributeBackView;
@property (weak, nonatomic) IBOutlet UIButton *contentChooseTextColorBtn;
@property (weak, nonatomic) IBOutlet UITextField *contentTextFontSizeTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentLineMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentTopMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentEdgeMarginTxtView;
//@property (weak, nonatomic) IBOutlet UITextField *contentRightTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentBottomTxtView;
@property (weak, nonatomic) IBOutlet UITextField *contentColor;

@property (weak, nonatomic) IBOutlet UIView *backSetupView;
@property (weak, nonatomic) IBOutlet UIButton *backgroundColorSelectBtn;
@property (weak, nonatomic) IBOutlet UILabel *backgroundColor;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UIButton *editSureBtn;


@property (strong, nonatomic) UIView *curEditView;

@end

@implementation ZZFormatEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTargetAction];
    

    [self setupTitleScrollView];
    
//    _chooseTextColorBtn.layer.cornerRadius = 5.0;
//    _chooseTextColorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _chooseTextColorBtn.layer.borderWidth = MIN_Scale;
//    
//    _contentChooseTextColorBtn.layer.cornerRadius = 5.0;
//    _contentChooseTextColorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _contentChooseTextColorBtn.layer.borderWidth = MIN_Scale;
//    
//    _backgroundColorSelectBtn.layer.cornerRadius = 5.0;
//    _backgroundColorSelectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _backgroundColorSelectBtn.layer.borderWidth = MIN_Scale;
    
    [self segmentControlClick:_segControl];
    
    
    
    
    

}


- (void)addTargetAction {
    [_segControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];

    [_editSureBtn addTarget:self action:@selector(editCompleteClick:) forControlEvents:UIControlEventTouchUpInside];

    [_chooseTextColorBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentChooseTextColorBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];

    [_backgroundColorSelectBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupTitleScrollView {
//    _titleEditScrollView.scrollEnabled = NO;
//    [_titleEditScrollView setContentSize:CGSizeMake(ScreenWidth * 4, 260)];
//
//    NSLog(@"%f",self.view.height);
//    
//    [_titleEdgeBackView setFrame:CGRectMake(0, 0, ScreenWidth, 260)];
//    [_attributeBackView setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 260)];
//    [_backSetupView setFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, 260)];
    
    _titleEdgeBackView.alpha = 0;
    _attributeBackView.alpha = 0;
    _backSetupView.alpha = 0;

    
    self.topMarginTxtView.delegate =  self;
    self.edgeMarginTxtView.delegate =  self;
    self.textFontSizeTxtView.delegate =  self;
    self.lineMarginTxtView.delegate =  self;
    self.titleColor.delegate =  self;
    
    
    self.contentTopMarginTxtView.delegate =  self;
    self.contentEdgeMarginTxtView.delegate =  self;
    self.contentBottomTxtView.delegate =  self;
    self.contentTextFontSizeTxtView.delegate =  self;
    self.contentLineMarginTxtView.delegate =  self;
    self.contentColor.delegate =  self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.contentChooseTextColorBtn.backgroundColor = [UIColor colorWithHex:self.contentColor.text];
    
    self.chooseTextColorBtn.backgroundColor = [UIColor colorWithHex:self.titleColor.text];

    self.backgroundColorSelectBtn.backgroundColor = [UIColor colorWithHex:self.backgroundColor.text];

    [self editCompleteClick:nil];
    
}

#pragma mark - FCColorPickerViewControllerDelegate
- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
    
    if (_segControl.selectedSegmentIndex == 0) {
        _chooseTextColorBtn.backgroundColor = color;
        
        _titleColor.text = [NSString hexFromUIColor:color];
        _titleColor.textColor = color;


    } else if (_segControl.selectedSegmentIndex == 1) {
        _contentChooseTextColorBtn.backgroundColor = color;
        
        _contentColor.text = [NSString hexFromUIColor:color];
        _contentColor.textColor = color;

    } else if (_segControl.selectedSegmentIndex == 3) {
        _backgroundColorSelectBtn.backgroundColor = color;
        
        _backgroundColor.text = [NSString hexFromUIColor:color];
        _backgroundColor.textColor = color;
    }
    
    WS(weakSelf);
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf editCompleteClick:nil];

    }];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Event Response
- (void)editCompleteClick:(UIButton *)sender {
    
    ZZFormatEditModel *editModel = [[ZZFormatEditModel alloc]init];
    
    
    editModel.topMargin = [self.topMarginTxtView.text floatValue];
//    editModel.leftMargin = [self.rightMarginTxtView.text floatValue];
    editModel.edgeMargin = [self.edgeMarginTxtView.text floatValue];
    editModel.titleColor = self.chooseTextColorBtn.backgroundColor;
    editModel.titleFontSize = [self.textFontSizeTxtView.text floatValue];
    editModel.lineMargin = [self.lineMarginTxtView.text floatValue];
    
    editModel.topMarginContent = [self.contentTopMarginTxtView.text floatValue];
//    editModel.leftMarginContent = [self.contentleftMarginTxtView.text floatValue];
    editModel.edgeMarginContent = [self.contentEdgeMarginTxtView.text floatValue];
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
    
//    [_titleEditScrollView setContentOffset:CGPointMake(ScreenWidth * seg.selectedSegmentIndex, 0) animated:NO];
    
    UIView *selectedView = nil;
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            selectedView = _titleEdgeBackView;
        break;
        
        case 1:
            selectedView = _attributeBackView;
        break;
        
        case 2:
        
        break;
        
        case 3:
            selectedView =_backSetupView;
        break;
        
        default:
        break;
    }
    
    selectedView.right = selectedView.right - 20;
    
    if (selectedView) {
        [UIView animateWithDuration:0.2 animations:^{
            
            _curEditView.right = _curEditView.right + 20;
            _curEditView.alpha = 0;
            
            
            selectedView.right = selectedView.right + 20;
            selectedView.alpha = 1;
            
            
            
        } completion:^(BOOL finished) {
            
            _curEditView.right = _curEditView.right - 20;
            
            _curEditView = selectedView;
            
        }];
    }
    
    

    
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
        self.edgeMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.edgeMargin];
//        self.rightMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.rightMargin];
        
        self.chooseTextColorBtn.backgroundColor = _editModel.titleColor;
        self.textFontSizeTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.titleFontSize];
        self.lineMarginTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.lineMargin];
        self.titleColor.text = [NSString hexFromUIColor:_editModel.titleColor];

        
        self.contentTopMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.topMarginContent];
        self.contentEdgeMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.edgeMarginContent];
//        self.contentRightTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.rightMarginContent];
        self.contentBottomTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.bottomMarginContent];

        self.contentChooseTextColorBtn.backgroundColor = _editModel.titleColorContent;
        self.contentTextFontSizeTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.titleFontSizeContent];
        self.contentLineMarginTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.lineMarginContent];
        self.contentColor.text = [NSString hexFromUIColor:_editModel.titleColorContent];

        
        
        self.backgroundColorSelectBtn.backgroundColor = _editModel.bgColor;
        self.backgroundColor.text = [NSString hexFromUIColor:_editModel.bgColor];
    }
}

@end
