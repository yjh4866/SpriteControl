//
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

@interface SKButton : SKControl

// textLabel是SKButton的基本元素
@property (nonatomic, readonly) SKLabelNode *textLabel;

@property (nonatomic, readonly) SKSpriteNode *spriteNode;
// 用SKSpriteNode实例化一个按钮
- (instancetype)initWithSize:(CGSize)size andSprite:(SKSpriteNode *)spriteNode;
- (instancetype)initWithSize:(CGSize)size andSpriteName:(NSString *)spriteName;


@property (nonatomic, readonly) SKShapeNode *shapeNode;
// 用SKShapeNode实例化一个圆按钮
- (instancetype)initWithSize:(CGSize)size andShape:(SKShapeNode *)shapeNode;
- (instancetype)initWithSize:(CGSize)size andRadius:(CGFloat)radius;


// 用字符串实例化一个文本按钮
- (instancetype)initWithSize:(CGSize)size andText:(NSString *)text;

@end
