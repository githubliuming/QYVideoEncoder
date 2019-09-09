//
//  VideoEncoder.h
//  QYVideoEncoder
//
//  Created by Yuri Boyka on 2019/9/9.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>

NS_ASSUME_NONNULL_BEGIN
@interface VideoEncoderConfig : NSObject
//视频宽
@property(nonatomic,assign)int32_t width;
//视频高
@property(nonatomic,assign)int32_t height;
//视频 fps
@property(nonatomic,assign)NSInteger fps;
//视频属性配置字典
@property(nonatomic,strong)NSDictionary * propertyDic;

@property(nonatomic,assign)CMVideoCodecType type;

@property(nonatomic,strong)NSDictionary * sourceImageBufferAttributes;

@end
@interface VideoEncoder : NSObject
- (instancetype)initWithConfig:(VideoEncoderConfig *)config error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
