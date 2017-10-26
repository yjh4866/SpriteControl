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

#import <SpriteKit/SpriteKit.h>


typedef NS_ENUM(unsigned int, SKCtrlEvent) {
    SKCtrlEvent_Null,
    SKCtrlEvent_TouchDown,
    SKCtrlEvent_TouchDragInside,
    SKCtrlEvent_TouchDragOutside,
    SKCtrlEvent_TouchDragEnter,
    SKCtrlEvent_TouchDragExit,
    SKCtrlEvent_TouchUpInside,
    SKCtrlEvent_TouchUpOutside,
    SKCtrlEvent_TouchCancel,
};


@interface SKControl : SKNode

@property (nonatomic, readonly) SKSpriteNode *bgSprite;

@property (nonatomic, assign) BOOL animationWhenTouch;

@property (nonatomic, copy) void (^touchDown)(id skControl);
@property (nonatomic, copy) void (^touchDragInside)(id skControl);
@property (nonatomic, copy) void (^touchDragOutside)(id skControl);
@property (nonatomic, copy) void (^touchDragEnter)(id skControl);
@property (nonatomic, copy) void (^touchDragExit)(id skControl);
@property (nonatomic, copy) void (^touchUpInside)(id skControl);
@property (nonatomic, copy) void (^touchUpOutside)(id skControl);
@property (nonatomic, copy) void (^touchCancel)(id skControl);

@property (nonatomic, copy) BOOL (^canMoveTo)(id skControl, CGPoint willPosition);


- (instancetype)initWithSize:(CGSize)size;

// 为指定事件设置动画
- (void)setAction:(SKAction *)action forControlEvent:(SKCtrlEvent)ctrlEvent;
// 获取指定事件的动画
- (SKAction *)actionOfControlEvent:(SKCtrlEvent)ctrlEvent;

@end
