//
//  NBLButton.m
//  
//
//  Created by GangX_yangjh on 2018/4/22.
//  Copyright © 2018年 SiSiKJ. All rights reserved.
//

#import "NBLButton.h"

@interface NBLButton ()
@property (nonatomic, strong) SKSpriteNode *spriteNode;
@property (nonatomic, strong) SKShapeNode *shapeNode;
@property (nonatomic, strong) SKLabelNode *textLabel;
@end

@implementation NBLButton

- (instancetype)init
{
    return [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andSprite:nil];
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
    [self setNormalBlock:^(NBLButton *nblButton){
        nblButton.spriteNode.texture = [SKTexture textureWithImageNamed:normalImageNamed];
    } touchDownBlock:^(NBLButton *nblButton){
        nblButton.spriteNode.texture = [SKTexture textureWithImageNamed:touchDownImageNamed];
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


- (void)setNormalBlock:(void (^)(NBLButton *nblButton))blockNormal
        touchDownBlock:(void (^)(NBLButton *nblButton))blockTouchDown
{
    __weak typeof(self) weakSelf = self;
    [self setAction:[SKAction runBlock:^{if(blockTouchDown)blockTouchDown(weakSelf);}]
    forControlEvent:NBLCtrlEvent_TouchDown];
    [self setAction:[SKAction runBlock:^{if(blockNormal)blockNormal(weakSelf);}] forControlEvent:NBLCtrlEvent_TouchUpInside];
    [self setAction:[SKAction runBlock:^{if(blockNormal)blockNormal(weakSelf);}] forControlEvent:NBLCtrlEvent_TouchUpOutside];
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
    CGFloat xScale = self.xScale, yScale = self.yScale;
    SKAction *actionShrink = [SKAction group:@[[SKAction scaleXTo:.85f*xScale duration:.1f],[SKAction scaleYTo:.85f*yScale duration:.1f]]];
    SKAction *actionEnlarge = [SKAction group:@[[SKAction scaleXTo:xScale duration:.1f],[SKAction scaleYTo:yScale duration:.1f]]];
    [self setAction:actionShrink forControlEvent:NBLCtrlEvent_TouchDown];
    [self setAction:actionEnlarge forControlEvent:NBLCtrlEvent_TouchUpInside];
    [self setAction:actionEnlarge forControlEvent:NBLCtrlEvent_TouchUpOutside];
    [self setAction:actionEnlarge forControlEvent:NBLCtrlEvent_TouchCancel];
}

@end
