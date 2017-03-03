//
//  DWExampleViewController.m
//  DWExample
//
//  Created by Developer Wan on 16/11/10.
//  Copyright © 2016年 Developer Wan. All rights reserved.
//

#import "DWExampleViewController.h"
#import "DWCell.h"
#import "DWModel.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define DWCellID @"cell"
#define DWMaxCount 100

@interface DWExampleViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,strong) NSMutableArray *modelArray;
@property (nonatomic ,strong) NSTimer *timer;
@end

@implementation DWExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCollectionView];
    
    [self setupPageControl];
}


# pragma mark - Building UI

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 250);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredHorizontally;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 250) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[DWCell class] forCellWithReuseIdentifier:DWCellID];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:DWMaxCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(SCREEN_WIDTH * 0.5, 220 + 64);
    pageControl.bounds = CGRectMake(0, 0, 150, 40);
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.enabled = NO;
    pageControl.numberOfPages = _modelArray.count;
    [self.view addSubview:pageControl];
    _pageControl=pageControl;
    
    [self addTimer];
}

# pragma mark - 添加定时器

-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

# pragma mark - 删除定时器

-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void) nextpage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:DWMaxCount/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.modelArray.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return DWMaxCount;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DWCellID forIndexPath:indexPath];
    if(!cell){
        cell = [[DWCell alloc] init];
    }
    cell.model = self.modelArray[indexPath.item];
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark - 当用户停止的时候调用

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

#pragma mark - 设置页码

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.modelArray.count;
    self.pageControl.currentPage =page;
}

# pragma mark - Lazy

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path =[bundle pathForResource:@"resource.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _modelArray=[NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            [_modelArray addObject:[DWModel modelWithDict:dict]];
        }
    }
    return _modelArray;
}

@end
