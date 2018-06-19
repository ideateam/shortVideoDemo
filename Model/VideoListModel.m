//
//  VideoListModel.m
//  ZFPlayerAVPlayerDemo
//
//  Created by Derek on 2018/6/13.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        self.nick_name = [NSString stringWithFormat:@"%@",dic[@"nick_name"]];
        self.head = [NSString stringWithFormat:@"%@",dic[@"head"]];
        self.thread_id = [NSString stringWithFormat:@"%@",dic[@"thread_id"]];
        self.first_post_id = [NSString stringWithFormat:@"%@",dic[@"first_post_id"]];
        self.create_time = [NSString stringWithFormat:@"%@",dic[@"create_time"]];
        self.play_count = [NSString stringWithFormat:@"%@",dic[@"play_count"]];
        self.post_num = [NSString stringWithFormat:@"%@",dic[@"post_num"]];
        self.agree_num = [NSString stringWithFormat:@"%@",dic[@"agree_num"]];
        self.share_num = [NSString stringWithFormat:@"%@",dic[@"share_num"]];
        self.has_agree = [NSString stringWithFormat:@"%@",dic[@"has_agree"]];
        self.freq_num = [NSString stringWithFormat:@"%@",dic[@"freq_num"]];
        self.forum_id = [NSString stringWithFormat:@"%@",dic[@"forum_id"]];
        self.title = [NSString stringWithFormat:@"%@",dic[@"title"]];
        self.source = [NSString stringWithFormat:@"%@",dic[@"source"]];
        self.weight = [NSString stringWithFormat:@"%@",dic[@"weight"]];
        self.extra = [NSString stringWithFormat:@"%@",dic[@"extra"]];
        self.abtest_tag = [NSString stringWithFormat:@"%@",dic[@"abtest_tag"]];
        self.thumbnail_width = [NSString stringWithFormat:@"%@",dic[@"thumbnail_width"]];
        self.thumbnail_height = [NSString stringWithFormat:@"%@",dic[@"thumbnail_height"]];
        self.video_md5 = [NSString stringWithFormat:@"%@",dic[@"video_md5"]];
        self.video_url = [NSString stringWithFormat:@"%@",dic[@"video_url"]];
        self.video_duration = [NSString stringWithFormat:@"%@",dic[@"video_duration"]];
        self.video_width = [NSString stringWithFormat:@"%@",dic[@"video_width"]];
        self.video_height = [NSString stringWithFormat:@"%@",dic[@"video_height"]];
        self.video_length = [NSString stringWithFormat:@"%@",dic[@"video_length"]];
        self.video_type = [NSString stringWithFormat:@"%@",dic[@"video_type"]];
        self.cover_text = [NSString stringWithFormat:@"%@",dic[@"cover_text"]];
        self.thumbnail_url = [NSString stringWithFormat:@"%@",dic[@"thumbnail_url"]];
        self.video_log_id = [NSString stringWithFormat:@"%@",dic[@"video_log_id"]];
        self.auditing = [NSString stringWithFormat:@"%@",dic[@"auditing"]];
        self.format_matched = [NSString stringWithFormat:@"%@",dic[@"format_matched"]];
        self.origin_video_url = [NSString stringWithFormat:@"%@",dic[@"origin_video_url"]];
        self.video_size = [NSString stringWithFormat:@"%@",dic[@"video_size"]];
        
    }
    return self;
}
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}
@end
