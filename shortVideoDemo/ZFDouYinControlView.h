//
//  ZFDouYinControlView.h
//  ZFPlayer_Example
//
//  Created by Derek on 2018/6/4.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"

@protocol TableCellBTNClickDelegate<NSObject>

-(void)clickHeadIconBTN:(UIButton *)HeadIconBTN;
-(void)clickLikeBTN:(UIButton *)LikeBTN;
-(void)clickCommentBTN:(UIButton *)CommentBTN;
-(void)clickShareBTN:(UIButton *)ShareBTN;

@end

@interface ZFDouYinControlView : UIView <ZFPlayerMediaControl>

- (void)resetControlView;

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl;

@property (nonatomic,weak) id<TableCellBTNClickDelegate> delegate;

@end
