//
//  ScreenMacro.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/22.
//  Copyright © 2016年 Wii. All rights reserved.
//

#ifndef ScreenMacro_h
#define ScreenMacro_h

#pragma mark --屏幕相关
#pragma mark --- 屏幕宽、高比例

#define RealScaleValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)
#define RealScaleValueY(value) ((value)/667.0f*[UIScreen mainScreen].bounds.size.height)
// 屏幕高度
#define SCREEN_HEIGHT             [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH              [[UIScreen mainScreen] bounds].size.width
//屏幕比例，方便做适配，以5s为基准
#define SCREEN_WIDTH_VECTOR (SCREEN_WIDITH/320)
#define SCREEN_HEIGHT_VECTOR (SCREEN_HEIGHT/568)
// 输出 rect，size 和 point
#define NSLogRect(rect)         NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size)         NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point)       NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)


#endif /* ScreenMacro_h */
