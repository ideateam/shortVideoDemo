//
//  ZFDouYinControlView.m
//  ZFPlayer_Example
//
//  Created by 任子丰 on 2018/6/4.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFDouYinControlView.h"
#import "UIView+ZFFrame.h"
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "ZFLoadingView.h"

@interface ZFDouYinControlView ()

/// 封面图
@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIButton *headIconBtn;

@property (nonatomic, strong) UIButton *likeBtn;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImage *placeholderImage;
/// 加载loading
@property (nonatomic, strong) ZFLoadingView *activity;

@end

@implementation ZFDouYinControlView
@synthesize player = _player;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.coverImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.headIconBtn];
        [self addSubview:self.likeBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.activity];
        [self addSubview:self.playBtn];
        [self resetControlView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coverImageView.frame = self.bounds;
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.width;
    CGFloat min_view_h = self.height;
    CGFloat margin = 30;
    
    min_w = 44;
    min_h = 44;
    self.activity.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.activity.center = self.center;
    
    min_w = 44;
    min_h = 44;
    self.playBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.playBtn.center = self.center;
    
    min_w = 40;
    min_h = min_w;
    min_x = min_view_w - min_w - 20;
    min_y = min_view_h - min_h - 80;
    self.shareBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_w = CGRectGetWidth(self.shareBtn.frame);
    min_h = min_w;
    min_x = CGRectGetMinX(self.shareBtn.frame);
    min_y = CGRectGetMinY(self.shareBtn.frame) - min_h - margin;
    self.commentBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_w = CGRectGetWidth(self.shareBtn.frame);
    min_h = min_w;
    min_x = CGRectGetMinX(self.commentBtn.frame);
    min_y = CGRectGetMinY(self.commentBtn.frame) - min_h - margin;
    self.likeBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_w = CGRectGetWidth(self.likeBtn.frame);
    min_h = min_w;
    min_x = CGRectGetMinX(self.likeBtn.frame);
    min_y = CGRectGetMinY(self.likeBtn.frame) - min_h - margin;
    self.headIconBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 20;
    min_h = 20;
    min_y = min_view_h - min_h - 50;
    min_w = self.likeBtn.left - margin;
    self.titleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl {
    self.titleLabel.text = title;
    [self.coverImageView setImageWithURLString:coverUrl placeholder:self.placeholderImage];
}

- (void)resetControlView {
    self.playBtn.hidden = YES;
    self.titleLabel.text = @"";
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStatePrepare) {
        self.coverImageView.hidden = NO;
    } else if (state == ZFPlayerLoadStatePlaythroughOK) {
        self.coverImageView.hidden = YES;
    }
    if (state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) {
        [self.activity startAnimating];
    } else {
        [self.activity stopAnimating];
    }
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (self.player.currentPlayerManager.isPlaying) {
        [self.player.currentPlayerManager pause];
         self.playBtn.hidden = NO;
    } else {
        [self.player.currentPlayerManager play];
        self.playBtn.hidden = YES;
    }
}

- (ZFLoadingView *)activity {
    if (!_activity) {
        _activity = [[ZFLoadingView alloc] init];
        _activity.lineWidth = 0.8;
        _activity.duration = 1;
        _activity.hidesWhenStopped = YES;
    }
    return _activity;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
- (UIButton *)headIconBtn {
    if (!_headIconBtn) {
        _headIconBtn = [[UIButton alloc]init];
        _headIconBtn.layer.cornerRadius = 20;
        _headIconBtn.clipsToBounds = YES;
        [_headIconBtn setImage:[UIImage imageNamed:@"headIcon.jpg"] forState:UIControlStateNormal];
        [_headIconBtn addTarget:self action:@selector(clickHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headIconBtn;
}
- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}


- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(clickCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.userInteractionEnabled = NO;
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
    }
    return _playBtn;
}

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        _placeholderImage = [ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    return _placeholderImage;
}
-(void)clickHeadBtn:(UIButton *)BTN {
    
    if ([_delegate respondsToSelector:@selector(clickHeadIconBTN:)]) {
        [_delegate clickHeadIconBTN:_headIconBtn];
    }
}
-(void)clickLikeBtn:(UIButton *)BTN {
    if ([_delegate respondsToSelector:@selector(clickLikeBTN:)]) {
        [_delegate clickLikeBTN:_likeBtn];
    }
}
-(void)clickCommentBtn:(UIButton *)BTN {
    if ([_delegate respondsToSelector:@selector(clickCommentBTN:)]) {
        [_delegate clickCommentBTN:_commentBtn];
    }
}
-(void)clickShareBtn:(UIButton *)BTN {
    if ([_delegate respondsToSelector:@selector(clickShareBTN:)]) {
        [_delegate clickShareBTN:_shareBtn];
    }
}
@end
