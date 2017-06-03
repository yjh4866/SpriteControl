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

#import "SKButton.h"


@interface SKButton ()
@property (nonatomic, strong) SKSpriteNode *spriteNode;
@property (nonatomic, strong) SKShapeNode *shapeNode;
@property (nonatomic, strong) SKLabelNode *textLabel;
@end


@implementation SKButton

- (instancetype)init
{
    return [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andSprite:nil];
}

- (void)dealloc
{
    
}


// 用SKSpriteNode实例化一个按钮
- (instancetype)initWithSize:(CGSize)size andSprite:(SKSpriteNode *)spriteNode
{
    self = [super initWithSize:size];
    if (self) {
        self.userInteractionEnabled = YES;
        self.animationWhenTouch = YES;
        // SKSpriteNode按钮
        self.spriteNode = spriteNode;
        if (self.spriteNode) {
            [self addChild:self.spriteNode];
        }
        // 初始化按钮文本，设置事件Action
        [self initTextAndAction];
    }
    return self;
}
- (instancetype)initWithSize:(CGSize)size andSpriteName:(NSString *)spriteName
{
    self = [super initWithSize:size];
    if (self) {
        self.userInteractionEnabled = YES;
        self.animationWhenTouch = YES;
        // SKSpriteNode按钮
        self.spriteNode = [SKSpriteNode spriteNodeWithImageNamed:spriteName];
        if (self.spriteNode) {
            [self addChild:self.spriteNode];
        }
        // 初始化按钮文本，设置事件Action
        [self initTextAndAction];
    }
    return self;
}
- (void)setNormalImageNamed:(NSString *)normalImageNamed
        touchDownImageNamed:(NSString *)touchDownImageNamed
{
    [self setNormalBlock:^(SKButton *skButton){
        skButton.spriteNode.texture = [SKTexture textureWithImageNamed:normalImageNamed];
    } touchDownBlock:^(SKButton *skButton){
        skButton.spriteNode.texture = [SKTexture textureWithImageNamed:touchDownImageNamed];
    }];
}


// 用SKShapeNode实例化一个按钮
- (instancetype)initWithSize:(CGSize)size andShape:(SKShapeNode *)shapeNode
{
    self = [super initWithSize:size];
    if (self) {
        self.userInteractionEnabled = YES;
        self.animationWhenTouch = YES;
        // SKShapeNode按钮
        self.shapeNode = shapeNode;
        if (self.shapeNode) {
            [self addChild:self.shapeNode];
        }
        // 初始化按钮文本，设置事件Action
        [self initTextAndAction];
    }
    return self;
}
- (instancetype)initWithSize:(CGSize)size andRadius:(CGFloat)radius
{
    self = [super initWithSize:size];
    if (self) {
        self.userInteractionEnabled = YES;
        self.animationWhenTouch = YES;
        // SKShapeNode按钮
        self.shapeNode = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
        [self addChild:self.shapeNode];
        // 初始化按钮文本，设置事件Action
        [self initTextAndAction];
    }
    return self;
}

// 用字符串实例化一个文本按钮
- (instancetype)initWithSize:(CGSize)size andText:(NSString *)text
{
    self = [super initWithSize:size];
    if (self) {
        self.userInteractionEnabled = YES;
        self.animationWhenTouch = YES;
        // 初始化按钮文本，设置事件Action
        [self initTextAndAction];
        // 文本按钮初始值
        self.textLabel.text = text;
    }
    return self;
}


- (void)setNormalBlock:(void (^)(SKButton *skButton))blockNormal
        touchDownBlock:(void (^)(SKButton *skButton))blockTouchDown
{
    [self setAction:[SKAction runBlock:^{blockTouchDown(self);}]
    forControlEvent:SKCtrlEvent_TouchDown];
    [self setAction:[SKAction runBlock:^{blockNormal(self);}] forControlEvent:SKCtrlEvent_TouchUpInside];
    [self setAction:[SKAction runBlock:^{blockNormal(self);}] forControlEvent:SKCtrlEvent_TouchUpOutside];
}


#pragma mark - Private

// 初始化按钮文本，设置事件Action
- (void)initTextAndAction
{
    // 按钮上的文本
    self.textLabel = [SKLabelNode labelNodeWithText:@""];
    self.textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [self addChild:self.textLabel];
    // 各种动作动画
    SKAction *actionShrink = [SKAction scaleTo:.85f duration:.1f];
    SKAction *actionEnlarge = [SKAction scaleTo:1.f duration:.1f];
    [self setAction:actionShrink forControlEvent:SKCtrlEvent_TouchDown];
    [self setAction:actionEnlarge forControlEvent:SKCtrlEvent_TouchUpInside];
    [self setAction:actionEnlarge forControlEvent:SKCtrlEvent_TouchUpOutside];
    [self setAction:actionEnlarge forControlEvent:SKCtrlEvent_TouchCancel];
}

@end
