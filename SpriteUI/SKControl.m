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
#import <objc/runtime.h>
#import "Aspects.h"


@implementation SKNode (SpriteUI)
- (void)updatePosition
{
    if (self.parent == self.scene) {
        self.position = CGPointMake((self.frameInSketch.origin.x+self.frameInSketch.size.width/2)-self.scene.anchorPoint.x*self.scene.size.width, -((self.frameInSketch.origin.y+self.frameInSketch.size.height/2)-(1-self.scene.anchorPoint.y)*self.scene.size.height));
    } else {
        self.position = CGPointMake((self.frameInSketch.origin.x+self.frameInSketch.size.width/2)-.5f*self.parent.frameInSketch.size.width, -((self.frameInSketch.origin.y+self.frameInSketch.size.height/2)-(1-.5f)*self.parent.frameInSketch.size.height));
    }
}
- (void)updateSize {}
static const char *SpriteUI_FrameInSketch = "SpriteUI_FrameInSketch";
- (void)setFrameInSketch:(CGRect)frameInSketch
{
    objc_setAssociatedObject(self, SpriteUI_FrameInSketch, [NSValue valueWithCGRect:frameInSketch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 当前SKNode已经被添加到SKScene，则计算其位置
    // 否则只能等被添加到SKScene才能计算位置
    if (self.scene) {
        [self updatePosition];
    }
    [self updateSize];
}
- (CGRect)frameInSketch
{
    return [objc_getAssociatedObject(self, SpriteUI_FrameInSketch) CGRectValue];
}
- (BOOL)exitFrameInSketch
{
    return objc_getAssociatedObject(self, SpriteUI_FrameInSketch) != nil;
}
@end


@interface SKSpriteNode (SpriteUI)
@end
@implementation SKSpriteNode (SpriteUI)
- (void)updateSize
{
    [super updateSize];
    if (self.texture.size.width > 0 && [self exitFrameInSketch]) {
        self.xScale = self.frameInSketch.size.width / self.texture.size.width;
    }
    if (self.texture.size.height > 0 && [self exitFrameInSketch]) {
        self.yScale = self.frameInSketch.size.height / self.texture.size.height;
    }
}
@end


@interface SKControl ()
@property (nonatomic, strong) SKSpriteNode *bgSprite;
@end

@implementation SKControl {
    NSMutableDictionary *_mdicActionForEvent;
    
    CGPoint _posTouchDown;
    CGPoint _posLastTouch;
}

+ (void)load
{
    // 绑定SKScene方法，等SKNode添加到SKScene后再计算其位置
    [SKScene aspect_hookSelector:@selector(addChild:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        // 设置过frameInSketch则更新其位置
        if (info.arguments.count > 0 &&
            [info.arguments[0] exitFrameInSketch]) {
            NSMutableArray *marrNode = [NSMutableArray arrayWithObject:info.arguments[0]];
            while (marrNode.count > 0) {
                SKNode *node = marrNode[0];
                if ([node exitFrameInSketch]) {
                    [node updatePosition];
                }
                [marrNode removeObjectAtIndex:0];
                //
                [marrNode addObjectsFromArray:node.children];
            }
        }
    } error:nil];
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
        _posTouchDown = pointTouch;
        _posLastTouch = pointTouch;
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
        if ([self containsPoint:_posLastTouch]) {
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
        if ([self containsPoint:_posLastTouch]) {
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
