//
//  ViewController.m
//  NewShortVideoDemo
//
//  Created by MacOS on 2019/4/29.
//  Copyright © 2019 MacOS. All rights reserved.
//

#import "ViewController.h"
#import "ZFDouYinViewController.h"

static NSString *kIdentifier = @"kIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *viewControllers;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ZFPlayer";
    [self.view addSubview:self.tableView];
    self.titles = @[@"键盘支持横屏",
                    @"普通样式",
                    @"列表HeaderView",
                    @"列表点击播放",
                    @"列表自动播放",
                    @"列表小窗播放",
                    @"列表明暗播放",
                    @"混合cell样式",
                    @"抖音样式",
                    @"抖音个人主页",
                    @"竖向滚动CollectionView",
                    @"横向滚动CollectionView",
                    @"全屏播放"];
    
    self.viewControllers = @[@"ZFKeyboardViewController",
                             @"ZFNoramlViewController",
                             @"ZFTableHeaderViewController",
                             @"ZFNotAutoPlayViewController",
                             @"ZFAutoPlayerViewController",
                             @"ZFSmallPlayViewController",
                             @"ZFLightTableViewController",
                             @"ZFMixViewController",
                             @"ZFDouYinViewController",
                             @"ZFCollectionViewListController",
                             @"ZFCollectionViewController",
                             @"ZFHorizontalCollectionViewController",
                             @"ZFFullScreenViewController"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *vcString = self.viewControllers[indexPath.row];
    UIViewController *viewController = [[NSClassFromString(vcString) alloc] init];
    if ([vcString isEqualToString:@"ZFDouYinViewController"]) {
        [(ZFDouYinViewController *)viewController playTheIndex:4];
    }
    viewController.navigationItem.title = self.titles[indexPath.row];
    if ([vcString isEqualToString:@"ZFFullScreenViewController"]) {
        [self.navigationController pushViewController:viewController animated:NO];
    } else {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

@end
