//
//  NBLControl.m
//  
//
//  Created by GangX_yangjh on 2018/4/22.
//  Copyright © 2018年 SiSiKJ. All rights reserved.
//

#import "NBLControl.h"


@interface NBLControl () {
    NSMutableDictionary *_mdicActionForEvent;
    
    CGPoint _posTouchDown;
    CGPoint _posLastTouch;
}
@property (nonatomic, strong) SKShapeNode *bgShape;
@end

@implementation NBLControl

- (instancetype)init
{
    return [self initWithSize:CGSizeMake(100, 100)];
}

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        _mdicActionForEvent = [NSMutableDictionary dictionary];
        // 背景，用于接收触摸事件
        self.bgShape = [SKShapeNode shapeNodeWithRectOfSize:size];
        self.bgShape.fillColor = [UIColor clearColor];
        self.bgShape.strokeColor = [UIColor clearColor];
        [self addChild:self.bgShape];
    }
    return self;
}

- (void)dealloc
{
    
}


#pragma mark - Override SKNode

- (CGRect)frame
{
    return self.bgShape.frame;
}

- (BOOL)containsPoint:(CGPoint)p
{
    return CGRectContainsPoint(self.frame, p);
}


#pragma mark - Public

// 为指定事件设置动画
- (void)setAction:(SKAction *)action forControlEvent:(NBLCtrlEvent)ctrlEvent
{
    _mdicActionForEvent[@(ctrlEvent)] = action;
}
// 获取指定事件的动画
- (SKAction *)actionOfControlEvent:(NBLCtrlEvent)ctrlEvent
{
    return _mdicActionForEvent[@(ctrlEvent)];
}


#pragma mark - Override UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint pointTouch = [touches.anyObject locationInNode:self];
    // 查看是否Touch在控件上
    if ([self containsPoint:pointTouch]) {
        _posTouchDown = pointTouch;
        _posLastTouch = pointTouch;
        // 回调的SKAction
        SKAction *callback = [SKAction runBlock:^{
            if (self.touchDown) {
                self.touchDown(self);
            }
        }];
        // 运行Action
        SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchDown];
        if (self.animationWhenTouch && action) {
            [self runAction:[SKAction sequence:@[action, callback]]];
        } else {
            [self runAction:callback];
        }
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint pointTouch = [touches.anyObject locationInNode:self];
    // 查看是否Touch在控件上
    if ([self containsPoint:pointTouch]) {
        if ([self containsPoint:_posLastTouch]) {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragInside) {
                    self.touchDragInside(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchDragInside];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
        else {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragEnter) {
                    self.touchDragEnter(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchDragEnter];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
    }
    else {
        if ([self containsPoint:_posLastTouch]) {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragExit) {
                    self.touchDragExit(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchDragExit];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
        else {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragOutside) {
                    self.touchDragOutside(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchDragOutside];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
    }
    if (self.willMoveTo) {
        CGPoint willPos = CGPointMake(self.position.x+(pointTouch.x-_posTouchDown.x),
                                      self.position.y+(pointTouch.y-_posTouchDown.y));
        self.position = self.willMoveTo(self, willPos);
    }
    _posLastTouch = pointTouch;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint pointTouch = [touches.anyObject locationInNode:self];
    // 查看是否Touch在控件上
    if ([self containsPoint:pointTouch]) {
        // 回调的SKAction
        SKAction *callback = [SKAction runBlock:^{
            if (self.touchUpInside) {
                self.touchUpInside(self);
            }
        }];
        // 运行Action
        SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchUpInside];
        if (self.animationWhenTouch && action) {
            [self runAction:[SKAction sequence:@[action, callback]]];
        } else {
            [self runAction:callback];
        }
    }
    else {
        // 回调的SKAction
        SKAction *callback = [SKAction runBlock:^{
            if (self.touchUpOutside) {
                self.touchUpOutside(self);
            }
        }];
        // 运行Action
        SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchUpOutside];
        if (self.animationWhenTouch && action) {
            [self runAction:[SKAction sequence:@[action, callback]]];
        } else {
            [self runAction:callback];
        }
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    // 回调的SKAction
    SKAction *callback = [SKAction runBlock:^{
        if (self.touchCancel) {
            self.touchCancel(self);
        }
    }];
    // 运行Action
    SKAction *action = [self actionOfControlEvent:NBLCtrlEvent_TouchCancel];
    if (self.animationWhenTouch && action) {
        [self runAction:[SKAction sequence:@[action, callback]]];
    } else {
        [self runAction:callback];
    }
}

@end
