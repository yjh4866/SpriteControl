//
//  NBLControl.h
//  
//
//  Created by GangX_yangjh on 2018/4/22.
//  Copyright © 2018年 SiSiKJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(unsigned int, NBLCtrlEvent) {
    NBLCtrlEvent_Null,
    NBLCtrlEvent_TouchDown,
    NBLCtrlEvent_TouchDragInside,
    NBLCtrlEvent_TouchDragOutside,
    NBLCtrlEvent_TouchDragEnter,
    NBLCtrlEvent_TouchDragExit,
    NBLCtrlEvent_TouchUpInside,
    NBLCtrlEvent_TouchUpOutside,
    NBLCtrlEvent_TouchCancel,
};

@interface NBLControl : SKNode

@property (nonatomic, readonly) SKShapeNode *bgShape;

@property (nonatomic, assign) BOOL animationWhenTouch;

@property (nonatomic, copy) void (^touchDown)(id nblControl);
@property (nonatomic, copy) void (^touchDragInside)(id nblControl);
@property (nonatomic, copy) void (^touchDragOutside)(id nblControl);
@property (nonatomic, copy) void (^touchDragEnter)(id nblControl);
@property (nonatomic, copy) void (^touchDragExit)(id nblControl);
@property (nonatomic, copy) void (^touchUpInside)(id nblControl);
@property (nonatomic, copy) void (^touchUpOutside)(id nblControl);
@property (nonatomic, copy) void (^touchCancel)(id nblControl);

@property (nonatomic, copy) CGPoint (^willMoveTo)(id nblControl, CGPoint willPosition);


- (instancetype)initWithSize:(CGSize)size;

// 为指定事件设置动画
- (void)setAction:(SKAction *)action forControlEvent:(NBLCtrlEvent)ctrlEvent;
// 获取指定事件的动画
- (SKAction *)actionOfControlEvent:(NBLCtrlEvent)ctrlEvent;

@end
