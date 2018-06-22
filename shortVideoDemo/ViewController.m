//
//  ViewController.m
//  shortVideoDemo
//
//  Created by Derek on 2018/6/19.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "ViewController.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFDouYinControlView.h"
#import "ZFDouYinCell.h"
#import "VideoListModel.h"
#import "UIImageView+WebCache.h"
#import "MyCenterViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TableCellBTNClickDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) ZFPlayerController *player;
@property (nonatomic,strong) ZFAVPlayerManager *playerManager;
@property (nonatomic,strong) ZFDouYinControlView *controlView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *urls;

@end

@implementation ViewController


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    @weakify(self)
    [self.tableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @strongify(self)
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playerManager pause];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.pagingEnabled = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView registerClass:[ZFDouYinCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    /// 停止的时候找出最合适的播放
    @weakify(self)
    _tableView.scrollViewDidStopScroll = ^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    };

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        __weak __typeof__(self) weakSelf = self;
        [weakSelf getData];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [weakSelf.tableView reloadData];
        });
        
    });
    
    /// playerManager
    self.playerManager = [[ZFAVPlayerManager alloc] init];
    
    /// player
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:self.playerManager containerViewTag:100];
    self.player.assetURLs = self.urls;
    self.player.shouldAutorotate = NO;
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesDoubleTap | ZFPlayerDisableGestureTypesPan |ZFPlayerDisableGestureTypesPinch;
    self.player.controlView = self.controlView;
    //@weakify(self)
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
    };
}

-(void)getData{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:72];
    _urls = [NSMutableArray new];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // NSLog(@"rootDict = %@",[rootDict valueForKey:@"list"]);
    
    for (NSDictionary * d in [rootDict valueForKey:@"list"] ) {
        
        VideoListModel *model = [VideoListModel modelWithDic:d];
        [array addObject:model];
        [self.urls addObject:[NSURL URLWithString:model.video_url]];
    }
    
    _dataArray = [NSMutableArray arrayWithArray:array];
    NSLog(@"self.urls = %@",self.urls);
    //[_tableView reloadData];
    
    //NSLog(@"------------------%ld---------------",_dataArray.count);
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFDouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[ZFDouYinCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellid"];
    }
    
    VideoListModel *model = _dataArray[indexPath.row];
    
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail_url]] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}

#pragma mark - ZFTableViewCellDelegate

- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

#pragma mark - private method

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    @weakify(self)
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop completionHandler:^{
        @strongify(self)
        [self.controlView resetControlView];
        VideoListModel *model = self.dataArray[indexPath.row];
        [self.controlView showTitle:model.title coverURLString:model.thumbnail_url];
    }];
}
- (ZFDouYinControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFDouYinControlView new];
        _controlView.delegate = self;
    }
    return _controlView;
}
-(void)clickHeadIconBTN:(UIButton *)HeadIconBTN{
    
    NSLog(@"click HeadIconBTN");
    MyCenterViewController *myCenter = [[MyCenterViewController alloc] init];
    [self.navigationController pushViewController:myCenter animated:YES];
}
-(void)clickLikeBTN:(UIButton *)LikeBTN{
    
    NSLog(@"click LikeBTN");
}
-(void)clickCommentBTN:(UIButton *)CommentBTN{
    NSLog(@"click CommentBTN");
}
-(void)clickShareBTN:(UIButton *)ShareBTN{
    NSLog(@"click ShareBTN");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
