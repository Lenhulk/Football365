//
//  WiiCircularlyView.h
//  CircularlyView
//
//  Created by Wii on 16/6/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectBlock)(NSInteger index); // 图片点击事件 Block

@class WiiCircularlyView;

@protocol WiiCircularlyViewDelegate <NSObject>

@optional
/**
 *  Block 代理方法任选一种实现，两者都先实现的话Block优先级高
 *
 *  @param wiiCircularlyView 循环滚动视图
 *  @param index             图片索引
 */
- (void)wiiCurcularly:(WiiCircularlyView *)wiiCircularlyView didSelectItemAtIndex:(NSInteger)index;

@end

@interface WiiCircularlyView : UIView
/**
 *  图片数组
 */
@property (nonatomic , strong) NSArray *images;
/**
 *  描述文字数组
 */
@property (nonatomic , strong) NSArray *describeArray;
/**
 *  图片点击代理方法
 */
@property (nonatomic , strong) id<WiiCircularlyViewDelegate> delegate;
/**
 *  自动滚动时间
 */
@property (nonatomic , assign) NSTimeInterval rollTime;
/**
 *  图片点击事件 Block
 */
@property (nonatomic , copy) DidSelectBlock didSelectBlock;

@end
