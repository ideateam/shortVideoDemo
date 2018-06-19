//
//  VideoListModel.h
//  ZFPlayerAVPlayerDemo
//
//  Created by Derek on 2018/6/13.
//  Copyright © 2018 Derek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListModel : NSObject
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *head;
@property (nonatomic,copy) NSString *thread_id;
@property (nonatomic,copy) NSString *first_post_id;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *play_count;
@property (nonatomic,copy) NSString *post_num;
@property (nonatomic,copy) NSString *agree_num;
@property (nonatomic,copy) NSString *share_num;
@property (nonatomic,copy) NSString *has_agree;
@property (nonatomic,copy) NSString *freq_num;
@property (nonatomic,copy) NSString *forum_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *extra;
@property (nonatomic,copy) NSString *abtest_tag;
@property (nonatomic,copy) NSString *thumbnail_width;
@property (nonatomic,copy) NSString *thumbnail_height;
@property (nonatomic,copy) NSString *video_md5;
@property (nonatomic,copy) NSString *video_url;
@property (nonatomic,copy) NSString *video_duration;
@property (nonatomic,copy) NSString *video_width;
@property (nonatomic,copy) NSString *video_height;
@property (nonatomic,copy) NSString *video_length;
@property (nonatomic,copy) NSString *video_type;
@property (nonatomic,copy) NSString *cover_text;
@property (nonatomic,copy) NSString *thumbnail_url;
@property (nonatomic,copy) NSString *video_log_id;
@property (nonatomic,copy) NSString *auditing;
@property (nonatomic,copy) NSString *format_matched;
@property (nonatomic,copy) NSString *origin_video_url;
@property (nonatomic,copy) NSString *video_size;


-(instancetype)initWithDictionary:(NSDictionary *)dic;
+(instancetype)modelWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
