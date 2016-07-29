//
//  NSTimer+CHWeakTimer.h
//  CHKit
//
//  Created by 陈 斐 on 16/4/14.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CHWeakTimer)

// 构造对象
+ (NSTimer *) scheduledCHWeakTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo;
+ (id)chWeakTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo;

// Timer控制
- (void) pauseCHWeakTimer;
- (void) resumeCHWeakTimer;
- (void) destroyCHWeakTimer;
@end
