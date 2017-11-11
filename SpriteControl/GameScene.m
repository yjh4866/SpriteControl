//
//  GameScene.m
//  SpriteControl
//
//  Created by 1JiaGame_yangjh on 2017/1/4.
//  Copyright © 2017年 1JiaGame. All rights reserved.
//

#import "GameScene.h"
#import "SKButton.h"


#define Color_Null  [UIColor colorWithWhite:0xEE/255.f alpha:1.f]
#define Color_Blue  [UIColor colorWithRed:0x50/255.f green:0xBE/255.f blue:0xDE/255.f alpha:1.f]
#define Color_Red   [UIColor colorWithRed:0xED/255.f green:0x49/255.f blue:0x4D/255.f alpha:1.f]

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setAction:[SKAction scaleTo:1.2 duration:.1f]
          forControlEvent:SKCtrlEvent_TouchDown];
        button.position = CGPointMake(-self.size.width/4, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        [self addChild:button];
    }
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        button.textLabel.text = @"Text";
        button.textLabel.fontColor = [UIColor blackColor];
        button.position = CGPointMake(0, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        [self addChild:button];
    }
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setAction:[SKAction moveBy:CGVectorMake(2, -5) duration:.1f]
           forControlEvent:SKCtrlEvent_TouchDown];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:SKCtrlEvent_TouchUpInside];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:SKCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction moveBy:CGVectorMake(-2, 5) duration:.1f]
           forControlEvent:SKCtrlEvent_TouchCancel];
        button.position = CGPointMake(self.size.width/4, self.size.height/4);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        [self addChild:button];
    }
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andRadius:50];
        button.shapeNode.fillColor = Color_Red;
        [button setNormalBlock:^(SKButton *skButton) {
            skButton.shapeNode.fillColor=Color_Red;
        } touchDownBlock:^(SKButton *skButton) {
            skButton.shapeNode.fillColor=Color_Blue;
        }];
        button.position = CGPointMake(-self.size.width/4, 0);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        [self addChild:button];
    }
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(100, 100) andSpriteName:@"Bu"];
        button.textLabel.text = @"Bu";
        button.textLabel.fontColor = [UIColor blackColor];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"ShiTou"];}]
           forControlEvent:SKCtrlEvent_TouchDown];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"Bu"];}]
           forControlEvent:SKCtrlEvent_TouchUpInside];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"JianDao"];}]
           forControlEvent:SKCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction runBlock:^(){button.spriteNode.texture=[SKTexture textureWithImageNamed:@"Bu"];}]
           forControlEvent:SKCtrlEvent_TouchCancel];
        button.position = CGPointMake(0, 0);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        // 是否可以移动到指定位置
        button.willMoveTo = ^CGPoint(SKControl *skControl, CGPoint willPosition) {
            return CGPointMake(willPosition.x, skControl.position.y);
        };
        [self addChild:button];
    }
    
    {
        SKButton *button = [[SKButton alloc] initWithSize:CGSizeMake(150, 150) andText:@"Button"];
        button.bgSprite.color = [UIColor colorWithWhite:.95f alpha:1];
        button.textLabel.fontColor = [UIColor blackColor];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"Down";}]
          forControlEvent:SKCtrlEvent_TouchDown];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"UpInside";}]
          forControlEvent:SKCtrlEvent_TouchUpInside];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"UpOutside";}]
          forControlEvent:SKCtrlEvent_TouchUpOutside];
        [button setAction:[SKAction runBlock:^(){button.textLabel.text = @"Cancel";}]
          forControlEvent:SKCtrlEvent_TouchCancel];
        button.position = CGPointMake(self.size.width/4, 0);
        // 点击事件
        button.touchUpInside = ^(SKButton *skButton){
            NSLog(@"TouchUpInside: %@", skButton);
        };
        // 是否可以移动到指定位置
        button.willMoveTo = ^CGPoint(SKControl *skControl, CGPoint willPosition) {
            return CGPointMake(skControl.position.x, willPosition.y);
        };
        [self addChild:button];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
