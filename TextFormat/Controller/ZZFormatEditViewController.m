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

@property (weak, nonatomic) IBOutlet UITextField *topMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *leftMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *bottomMarginTxtView;
@property (weak, nonatomic) IBOutlet UITextField *rightMarginTxtView;

@property (weak, nonatomic) IBOutlet UIView *attributeBackView;
@property (weak, nonatomic) IBOutlet UIButton *chooseTextColorBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFontSizeTxtView;
@property (weak, nonatomic) IBOutlet UITextField *lineMarginTxtView;


@property (weak, nonatomic) IBOutlet UIScrollView *contentEditScrollView;


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
}


- (void)addTargetAction {
    
    [_editSureBtn addTarget:self action:@selector(editCompleteClick:) forControlEvents:UIControlEventTouchUpInside];

    [_chooseTextColorBtn addTarget:self action:@selector(chooseTextColorClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)setupTitleScrollView {
//    _titleEditScrollView
    [_titleEditScrollView setContentSize:CGSizeMake(ScreenWidth * 2, 219)];

    NSLog(@"%f",self.view.height);
    
    [_titleEdgeBackView setFrame:CGRectMake(0, 0, ScreenWidth, 219)];
    [_attributeBackView setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 219)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - FCColorPickerViewControllerDelegate
- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
    _chooseTextColorBtn.backgroundColor = color;
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
    editModel.bottomMargin = [self.bottomMarginTxtView.text floatValue];
    editModel.rightMargin = [self.rightMarginTxtView.text floatValue];
    editModel.titleColor = self.chooseTextColorBtn.backgroundColor;
    editModel.titleFontSize = [self.textFontSizeTxtView.text floatValue];
    editModel.lineMargin = [self.lineMarginTxtView.text floatValue];
    
    if (_editCompletedBlock) {
        _editCompletedBlock(editModel);
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
        self.leftMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.leftMargin];
        self.rightMarginTxtView.text =  [NSString stringWithFormat:@"%.1f",_editModel.rightMargin];
        
        self.chooseTextColorBtn.backgroundColor = _editModel.titleColor;
        
        self.textFontSizeTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.titleFontSize];

        self.lineMarginTxtView.text =  [NSString stringWithFormat:@"%d",(int)_editModel.lineMargin];

        
    }
}

@end
