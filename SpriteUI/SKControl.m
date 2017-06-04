// The MIT License (MIT)
//
// Copyright (c) 2015-2016 NBL ( https://github.com/yjh4866/SpriteControl )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "SKControl.h"


@interface SKControl ()
@property (nonatomic, strong) SKSpriteNode *bgSprite;
@end


@implementation SKControl {
    NSMutableDictionary *_mdicActionForEvent;
    
    CGPoint _pointLastTouch;
}

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
        //
        self.bgSprite = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:size];
        [self addChild:self.bgSprite];
    }
    return self;
}

- (void)dealloc
{
    
}


#pragma mark - Override SKNode

- (CGRect)frame
{
    return self.bgSprite.frame;
}

- (BOOL)containsPoint:(CGPoint)p
{
    return CGRectContainsPoint(self.frame, p);
}


#pragma mark - Public

// 为指定事件设置动画
- (void)setAction:(SKAction *)action forControlEvent:(SKCtrlEvent)ctrlEvent
{
    _mdicActionForEvent[@(ctrlEvent)] = action;
}
// 获取指定事件的动画
- (SKAction *)actionOfControlEvent:(SKCtrlEvent)ctrlEvent
{
    return _mdicActionForEvent[@(ctrlEvent)];
}


#pragma mark - Override UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint pointTouch = [touches.anyObject locationInNode:self];
    // 查看是否Touch在控件上
    if ([self containsPoint:pointTouch]) {
        _pointLastTouch = pointTouch;
        // 回调的SKAction
        SKAction *callback = [SKAction runBlock:^{
            if (self.touchDown) {
                self.touchDown(self);
            }
        }];
        // 运行Action
        SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchDown];
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
        if ([self containsPoint:_pointLastTouch]) {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragInside) {
                    self.touchDragInside(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchDragInside];
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
            SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchDragEnter];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
    }
    else {
        if ([self containsPoint:_pointLastTouch]) {
            // 回调的SKAction
            SKAction *callback = [SKAction runBlock:^{
                if (self.touchDragExit) {
                    self.touchDragExit(self);
                }
            }];
            // 运行Action
            SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchDragExit];
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
            SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchDragOutside];
            if (self.animationWhenTouch && action) {
                [self runAction:[SKAction sequence:@[action, callback]]];
            } else {
                [self runAction:callback];
            }
        }
    }
    _pointLastTouch = pointTouch;
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
        SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchUpInside];
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
        SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchUpOutside];
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
    SKAction *action = [self actionOfControlEvent:SKCtrlEvent_TouchCancel];
    if (self.animationWhenTouch && action) {
        [self runAction:[SKAction sequence:@[action, callback]]];
    } else {
        [self runAction:callback];
    }
}

@end
