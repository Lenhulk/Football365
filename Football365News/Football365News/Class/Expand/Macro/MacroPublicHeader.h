//
//  MacroPublicHeader.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/22.
//  Copyright © 2016年 Wii. All rights reserved.
//

#ifndef MacroPublicHeader_h
#define MacroPublicHeader_h

#import "APIMacro.h"
#import "ScreenMacro.h"
#import "DateTools.h"
#import "WMPageController.h"

#define WeakSelf __weak __typeof(self) weakSelf = self

#define MyRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define MyRGBColor(r, g, b)         MyRGBAColor(r, g, b, 1)
#define MyRandomColor          MyRGBColor((arc4random_uniform(255)), (arc4random_uniform(255)), (arc4random_uniform(255)))
#define AppMainColor                MyRGBColor(255,28,56)

#endif /* MacroPublicHeader_h */
