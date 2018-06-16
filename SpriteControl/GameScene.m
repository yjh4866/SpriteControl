//
//  GameScene.m
//  SpriteControl
//
//  Created by 1JiaGame_yangjh on 2017/1/4.
//  Copyright © 2017年 1JiaGame. All rights reserved.
//

#import "GameScene.h"
#import "NBLButton.h"


#define Color_Null  [UIColor colorWithWhite:0xEE/255.f alpha:1.f]
#define Color_Blue  [UIColor colorWithRed:0x50/255.f green:0xBE/255.f blue:0xDE/255.f alpha:1.f]
#define Color_Red   [UIColor colorWithRed:0xED/255.f green:0x49/255.f blue:0x4D/255.f alpha:1.f]

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setAction:[SKAction scaleTo:1.2 duration:.1f]
          forControlEvent:NBLCtrlEvent_TouchDown];
        button.position = CGPointMake(-self.size.width/4, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        [self addChild:button];
    }
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        button.textLabel.text = @"Text";
        button.textLabel.fontColor = [UIColor blackColor];
        button.position = CGPointMake(0, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        [self addChild:button];
    }
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setAction:[SKAction moveBy:CGVectorMake(2, -5) duration:.1f]
           forControlEvent:NBLCtrlEvent_TouchDown];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:NBLCtrlEvent_TouchUpInside];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:NBLCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:NBLCtrlEvent_TouchCancel];
        button.position = CGPointMake(self.size.width/4, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        [self addChild:button];
    }
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setNormalBlock:^(NBLButton *nblButton) {
            nblButton.shapeNode.fillColor=Color_Red;
        } touchDownBlock:^(NBLButton *nblButton) {
            nblButton.shapeNode.fillColor=Color_Blue;
        }];
        button.position = CGPointMake(-self.size.width/4, 0);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        [self addChild:button];
    }
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(100, 100) andSpriteName:@"Bu"];
        button.textLabel.text = @"Bu";
        button.textLabel.fontColor = [UIColor blackColor];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"ShiTou"];}]
           forControlEvent:NBLCtrlEvent_TouchDown];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"Bu"];}]
           forControlEvent:NBLCtrlEvent_TouchUpInside];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"JianDao"];}]
           forControlEvent:NBLCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"Bu"];}]
           forControlEvent:NBLCtrlEvent_TouchCancel];
        button.position = CGPointMake(0, 0);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        // 是否可以移动到指定位置
        button.willMoveTo = ^CGPoint(NBLControl *nblControl, CGPoint willPosition) {
            return CGPointMake(willPosition.x, nblControl.position.y);
        };
        [self addChild:button];
    }
    
    {
        NBLButton *button = [[NBLButton alloc] initWithSize:CGSizeMake(150, 150) andText:@"Button"];
        button.textLabel.fontColor = [UIColor blackColor];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"Down";}]
          forControlEvent:NBLCtrlEvent_TouchDown];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"UpInside";}]
          forControlEvent:NBLCtrlEvent_TouchUpInside];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"UpOutside";}]
          forControlEvent:NBLCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"Cancel";}]
          forControlEvent:NBLCtrlEvent_TouchCancel];
        button.position = CGPointMake(self.size.width/4, 0);
        // 点击事件
        button.touchUpInside = ^(NBLButton *nblButton){
            NSLog(@"TouchUpInside: %@", nblButton);
        };
        // 是否可以移动到指定位置
        button.willMoveTo = ^CGPoint(NBLControl *nblControl, CGPoint willPosition) {
            return CGPointMake(nblControl.position.x, willPosition.y);
        };
        [self addChild:button];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
