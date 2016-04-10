//
//  MZCodeViewController.m
//  MZPop
//
//  Created by 张逸 on 16/4/10.
//  Copyright © 2016年 monzy613. All rights reserved.
//

#import "MZCodeViewController.h"

@interface MZCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *codeTextView;
@end

@implementation MZCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeTextView.text = self.code;
    // Do any additional setup after loading the view.
}

- (IBAction)dismissButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"ShowCodeUnwindSegue" sender:self];
}
@end
