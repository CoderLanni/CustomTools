//
//  NSTimer+addition.m
//  WYHomeLoopView
//
//  Created by 小毅 on 16/5/5.
//  Copyright © 2016年 医和你信息科技有限公司. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (NSTimer *)ry_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block {
    
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(timeFired:) userInfo:block repeats:yesOrNo];
}

+ (void)timeFired:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
