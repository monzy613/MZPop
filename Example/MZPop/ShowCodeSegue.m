//
//  ShowCodeSegue.m
//  MZPop
//
//  Created by 张逸 on 16/4/10.
//  Copyright © 2016年 monzy613. All rights reserved.
//

#import "ShowCodeSegue.h"
#import "MZPop.h"

@implementation ShowCodeSegue
- (void)perform
{
    NSLog(@"ShowCodeSegue");
    UIView *firstVCView = self.sourceViewController.view;
    UIView *secondVCView = self.destinationViewController.view;

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGPoint center = firstVCView.center;
    secondVCView.frame = CGRectMake(-screenSize.width, 0, screenSize.width, screenSize.height);
    [[UIApplication sharedApplication].keyWindow addSubview:secondVCView];

    [UIView animateWithDuration:0.3 animations:^{
        firstVCView.transform = CGAffineTransformScale(firstVCView.transform, 0.9, 0.9);
    }];
    [MZPop springMove:secondVCView location:center springBounciness:5 springSpeed:5 completion:^{
        [self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
    }];
}
@end
