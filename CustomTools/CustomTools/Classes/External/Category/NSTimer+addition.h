//
//  NSTimer+addition.h
//  WYHomeLoopView
//
//  Created by 小毅 on 16/5/5.
//  Copyright © 2016年 医和你信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

+ (NSTimer *)ry_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

@end
