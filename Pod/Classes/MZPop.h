//
//  MZPop.h
//  Pods
//
//  Created by 张逸 on 16/4/7.
//
//

#import <Foundation/Foundation.h>
#import <pop/POP.h>

@interface MZPop : NSObject
+ (void)springMove:(NSObject *)object
          location:(CGPoint)location
  springBounciness:(CGFloat)springBounciness
       springSpeed:(CGFloat)springSpeed
        completion:(void(^)(void))completion;

+ (void)springScaleXY:(NSObject *)object
                scale:(CGPoint)scale
     springBounciness:(CGFloat)springBounciness
          springSpeed:(CGFloat)springSpeed
           completion:(void(^)(void))completion;


+ (void)springRotateY:(NSObject *)object
     springBounciness:(CGFloat)springBounciness
          springSpeed:(CGFloat)springSpeed
           completion:(void(^)(void))completion;

+ (void)flipY:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion;

+ (void)decayMove:(NSObject *)object
        direction:(CGPoint)direction
       completion:(void(^)(void))completion;

//+ (void)decayScaleXY:(NSObject *)object
//        scale:(CGPoint)scale
//        velocity:(CGFloat)velocity
//        completion:(void(^)(void))completion;

@end
