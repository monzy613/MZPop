//
//  MZPop.m
//  Pods
//
//  Created by 张逸 on 16/4/7.
//
//

#import "MZPop.h"

@implementation MZPop

+ (void)springMove:(NSObject *)object
          location:(CGPoint)location
  springBounciness:(CGFloat)springBounciness
       springSpeed:(CGFloat)springSpeed
        completion:(void(^)(void))completion
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:location];
    anim.springBounciness = springBounciness;
    anim.springSpeed = springSpeed;
    [object pop_addAnimation:anim forKey:@"MZPop.springMove"];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            if (completion != nil) {
                completion();
            }
        }
    };
}

+ (void)springScaleXY:(NSObject *)object
                scale:(CGPoint)scale
     springBounciness:(CGFloat)springBounciness
          springSpeed:(CGFloat)springSpeed
           completion:(void(^)(void))completion
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:scale];
    anim.springBounciness = springBounciness;
    anim.springSpeed = springSpeed;
    [object pop_addAnimation:anim forKey:@"MZPop.springScaleXY"];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            if (completion != nil) {
                completion();
            }
        }
    };
}

+ (void)springRotateY:(NSObject *)object
      springBounciness:(CGFloat)springBounciness
           springSpeed:(CGFloat)springSpeed
            completion:(void(^)(void))completion
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationY];
    anim.toValue = @(M_PI);
    anim.springBounciness = 0;
    anim.springSpeed = springSpeed;
    [object pop_addAnimation:anim forKey:@"MZPop.springRotateY"];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            if (completion != nil) {
                completion();
            }
        }
    };
}

+ (void)flipY:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    double angle = 180.0;
    //view.layer.transform = [self get3DTransformation:angle];
    [UIView animateWithDuration:duration animations:^{
        //view.layer.transform = CATransform3DIdentity;
        view.layer.transform = [self get3DTransformation:angle];
    } completion:^(BOOL finished) {
        if (finished && completion != nil) {
            completion();
        }
    }];
}

+ (CATransform3D)get3DTransformation:(double)angle
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, (CGFloat)(angle * M_PI / 180.0), 0, 1, 0);
    return transform;
}

+ (void)decayMove:(NSObject *)object
        direction:(CGPoint)direction
       completion:(void(^)(void))completion
{
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.velocity = [NSValue valueWithCGPoint:direction];
    [object pop_addAnimation:anim forKey:@"MZPop.decayMove"];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            if (completion != nil) {
                completion();
            }
        }
    };
}

@end
