//
//  MZViewController.m
//  MZPop
//
//  Created by monzy613 on 04/07/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

#import "MZViewController.h"
#import "MZCodeViewController.h"
#import "ShowCodeUnwindSegue.h"
#import <Masonry/Masonry.h>
#import "MZPop.h"
#define codeViewLeftOffset 50.0

@interface MZViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPickerView *animationPicker;
@property (weak, nonatomic) IBOutlet UISlider *leftSlider;
@property (weak, nonatomic) IBOutlet UISlider *rightSlider;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightNumberLabel;
@property (nonatomic) UIView *popBall;
@property (nonatomic) UILabel *labelInBall;
@property (nonatomic) NSArray<NSString *> *pickerTitles;
@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    [self.contentView addSubview:self.popBall];
    self.leftSlider.maximumValue = 15;
    self.leftSlider.minimumValue = 1;
    self.leftSlider.value = 5;
    self.rightSlider.maximumValue = 15;
    self.rightSlider.minimumValue = 1;
    self.rightSlider.value = 5;
    self.leftNumberLabel.text = [NSString stringWithFormat:@" %.1f", 5.0f];
    self.rightNumberLabel.text = [NSString stringWithFormat:@" %.1f", 5.0f];
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"ShowCodeUnwindSegue"]) {
        NSLog(@"ShowCodeUnwindSegue");
        ShowCodeUnwindSegue *unwindSegue = [[ShowCodeUnwindSegue alloc] initWithIdentifier:@"ShowCodeUnwindSegue" source:fromViewController destination:toViewController];
        return unwindSegue;
    }
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowCodeSegue"]) {
        MZCodeViewController *codeVC = segue.destinationViewController;
        codeVC.code = [NSString stringWithFormat:@"[MZPop springMove:self.popBall\nlocation:[self randomPoint]\nspringBounciness:%.1f\nspringSpeed:%.1f\ncompletion:nil];", self.leftSlider.value, self.rightSlider.value];
    }
}

- (IBAction)returnFromSegueActions:(UIStoryboardSegue *)segue
{
    NSLog(@"ShowCodeUnwindSegue");
}

#pragma mark privates
- (CGPoint)randomPoint
{
    CGSize viewSize = self.contentView.bounds.size;
    viewSize.height -= 160;
    CGFloat x = random() % (long)viewSize.width;
    CGFloat y = random() % (long)viewSize.height;
    return CGPointMake(x, y);
}

- (CGPoint)randomDirection
{
    CGSize viewSize = self.contentView.bounds.size;
    viewSize.height -= 160;
    CGFloat x = random() % (long)viewSize.width;
    CGFloat y = random() % (long)viewSize.height;
    x -= viewSize.width / 2;
    y -= viewSize.height / 2;
    return CGPointMake(x, y);
}

//- (void)setCode
//{
//    NSString *selectedAnimation = self.pickerTitles[[self.animationPicker selectedRowInComponent:0]];
//    if ([selectedAnimation isEqualToString:@"springMove"]) {
//        self.codeTextView.text = [NSString stringWithFormat:@"[MZPop springMove:self.popBall\nlocation:[self randomPoint]\nspringBounciness:%.1f\nspringSpeed:%.1f\ncompletion:nil];", self.leftSlider.value, self.rightSlider.value];
//    }
//}


#pragma mark button actions
- (IBAction)animateButtonPressed:(id)sender {
    [self.popBall pop_removeAllAnimations];
    NSString *selectedAnimation = self.pickerTitles[[self.animationPicker selectedRowInComponent:0]];
    if ([selectedAnimation isEqualToString:@"springMove"]) {
        [MZPop springMove:self.popBall
                 location:[self randomPoint]
         springBounciness:self.leftSlider.value
              springSpeed:self.rightSlider.value
               completion:nil];
    }
    else if ([selectedAnimation isEqualToString:@"scaleXY"]) {
        [MZPop springScaleXY:self.popBall
                       scale:CGPointMake(2, 2)
            springBounciness:self.leftSlider.value
                 springSpeed:self.rightSlider.value
                  completion:nil];
    }
    else if ([selectedAnimation isEqualToString:@"springRotateXY"]) {
        [MZPop springRotateY:self.popBall.layer
            springBounciness:5.0
                 springSpeed:5.0
                  completion:nil];
    }
    else if ([selectedAnimation isEqualToString:@"flipY"]) {
        [MZPop flipY:self.popBall
            duration:0.6
          completion:nil];
    }
    else if ([selectedAnimation isEqualToString:@"decayMove"]) {
        [MZPop decayMove:self.popBall.layer
               direction:[self randomDirection]
              completion:nil];
    }
}

- (IBAction)replaceButtonPressed:(id)sender
{
    CGPoint center = self.contentView.center;
    [self.popBall pop_removeAllAnimations];
    [MZPop springMove:self.popBall
             location:center springBounciness:5.0
          springSpeed:5.0
           completion:nil];

    [MZPop springScaleXY:self.popBall
                   scale:CGPointMake(1, 1)
        springBounciness:5.0
             springSpeed:5.0
              completion:nil];
}

- (IBAction)showCode:(id)sender
{
    [self performSegueWithIdentifier:@"ShowCodeSegue" sender:self];
}

- (IBAction)showOptions:(id)sender
{
    NSLog(@"showOptions");
}

#pragma mark slider actions
- (IBAction)leftSliderSlide:(id)sender {
    float newValue = ((UISlider *)sender).value;
    self.leftNumberLabel.text = [NSString stringWithFormat:@" %.1f", newValue];
}

- (IBAction)rightSliderSlide:(id)sender {
    float newValue = ((UISlider *)sender).value;
    self.rightNumberLabel.text = [NSString stringWithFormat:@" %.1f", newValue];
}


#pragma mark pickerview delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerTitles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerTitles[row];
}


#pragma mark getters
- (UIView *)popBall
{
    if (!_popBall) {
        CGFloat width = self.view.frame.size.width / 4;
        _popBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _popBall.center = self.contentView.center;
        _popBall.backgroundColor = [UIColor magentaColor];
        _popBall.layer.cornerRadius = width / 2;
        _popBall.clipsToBounds = YES;

        _labelInBall = [[UILabel alloc] init];
        _labelInBall.text = @"ball";
        _labelInBall.textColor = [UIColor whiteColor];
        _labelInBall.textAlignment = NSTextAlignmentCenter;
        [_popBall addSubview:_labelInBall];
        [_labelInBall mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_popBall.mas_left);
            make.right.equalTo(_popBall.mas_right);
            make.centerY.equalTo(_popBall.mas_centerY);
        }];
    }
    return _popBall;
}

- (NSArray<NSString *> *)pickerTitles
{
    if (!_pickerTitles) {
        _pickerTitles = @[@"springMove", @"scaleXY", @"flipY", @"springRotateXY", @"decayMove"];
    }
    return _pickerTitles;
}
@end
