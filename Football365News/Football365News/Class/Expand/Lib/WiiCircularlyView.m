//
//  WiiCircularlyView.m
//  CircularlyView
//
//  Created by Wii on 16/6/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "WiiCircularlyView.h"
#import "CircularlyCell.h"
#define identifier @"cirularlyCell"

@interface WiiCircularlyView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) NSInteger imageCount;
@end

@implementation WiiCircularlyView

- (void)dealloc {
    [self stopTimer];
    DLog(@"%s",__func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    self.imageCount = images.count * 500;
    if (images.count > 0) {
        [self setupTimer];
        self.pageControl.numberOfPages = images.count;
    }
    [self.collectionView reloadData];
}
/**
 *  设置描述文字数组
 *
 *  @param describeArray 如果count不等于images.count 则自动补全
 */
- (void)setDescribeArray:(NSArray *)describeArray {
    _describeArray = describeArray;
    if (describeArray.count < self.images.count) {
        NSMutableArray *describes = [NSMutableArray arrayWithArray:describeArray];
        for (NSInteger i = describeArray.count; i < self.images.count; i++) {
            [describes addObject:@" "];
        }
        _describeArray = describes;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self config];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.flowLayout.itemSize = self.frame.size;
    self.collectionView.frame = self.bounds;
    
    if (self.collectionView.contentOffset.x == 0 && self.imageCount) {
        
        int tarIndex = self.imageCount * 0.5;
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:tarIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (self.describeArray.count == 0) {
        self.pageControl.frame = CGRectMake((self.frame.size.width - 100)/2, self.frame.size.height - 30, 100, 20);
    } else {
        self.pageControl.frame = CGRectMake((self.frame.size.width - 100)/2, self.frame.size.height - 40, 100, 20);
    }

}
#pragma mark - NSTimer

- (void)setupTimer {
    if (self.images.count <= 1) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.rollTime target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - 配置控件
- (void)config {
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CircularlyCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    [self addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    [self addSubview:self.pageControl];
}
#pragma mark - 循环

/**
 *  获得当前图片在数组中的索引
 *
 *  @return 返回索引
 */
- (NSInteger)getCurrentIndex {
    NSInteger index = 0;
    if (self.collectionView.frame.size.width == 0) {
        return 0;
    }
    index = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    return index;
}



- (void)autoScroll {

    NSInteger targetIndex = [self getCurrentIndex] + 1 ;
    
    if (targetIndex >= self.imageCount) {
        targetIndex = self.imageCount * 0.5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CircularlyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.path = indexPath;
    cell.describeArray = self.describeArray;
    cell.images = self.images;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath.item % self.images.count);
    } else if ([self.delegate respondsToSelector:@selector(wiiCurcularly:didSelectItemAtIndex:)]) {
        [self.delegate wiiCurcularly:self didSelectItemAtIndex:indexPath.item % self.images.count];
    }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = [self getCurrentIndex];
    self.pageControl.currentPage = index % self.images.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

#pragma mark － 懒加载

- (NSTimeInterval)rollTime {
    if (!_rollTime) {
        _rollTime = 2.0;
    }
    return _rollTime;
}
@end
