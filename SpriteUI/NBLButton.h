//
//  NBLButton.h
//  
//
//  Created by GangX_yangjh on 2018/4/22.
//  Copyright © 2018年 SiSiKJ. All rights reserved.
//

#import "NBLControl.h"

@interface NBLButton : NBLControl

@property (nonatomic, readonly) SKSpriteNode *spriteNode;
// 用SKSpriteNode实例化一个按钮
- (instancetype)initWithSize:(CGSize)size andSprite:(SKSpriteNode *)spriteNode;
- (instancetype)initWithSize:(CGSize)size andSpriteName:(NSString *)spriteName;
- (void)setNormalImageNamed:(NSString *)normalImageNamed
        touchDownImageNamed:(NSString *)touchDownImageNamed;


@property (nonatomic, readonly) SKShapeNode *shapeNode;
// 用SKShapeNode实例化一个图形按钮
- (instancetype)initWithSize:(CGSize)size andShape:(SKShapeNode *)shapeNode;
- (instancetype)initWithSize:(CGSize)size andRadius:(CGFloat)radius;


@property (nonatomic, readonly) SKLabelNode *textLabel;
// 用字符串实例化一个文本按钮
- (instancetype)initWithSize:(CGSize)size andText:(NSString *)text;


- (void)setNormalBlock:(void (^)(NBLButton *nblButton))blockNormal
        touchDownBlock:(void (^)(NBLButton *nblButton))blockTouchDown;

@end
