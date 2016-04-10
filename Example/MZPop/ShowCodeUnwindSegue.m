//
//  ShowCodeUnwindSegue.m
//  MZPop
//
//  Created by 张逸 on 16/4/10.
//  Copyright © 2016年 monzy613. All rights reserved.
//

#import "ShowCodeUnwindSegue.h"
#import "MZPop.h"

@implementation ShowCodeUnwindSegue
- (void)perform
{
    UIView *sourceView = self.sourceViewController.view;
    UIView *destView = self.destinationViewController.view;

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGPoint newCenter = CGPointMake(-screenSize.width / 2, screenSize.height / 2);

    [UIView animateWithDuration:0.3 animations:^{
        destView.transform = CGAffineTransformScale(sourceView.transform, 1, 1);
    }];

    [MZPop springMove:sourceView location:newCenter springBounciness:5.0 springSpeed:5.0 completion:^{
        [self.sourceViewController dismissViewControllerAnimated:false completion:nil];
    }];
}
@end
