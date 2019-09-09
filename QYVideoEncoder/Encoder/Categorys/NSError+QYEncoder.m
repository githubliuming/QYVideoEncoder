//
//  NSError+QYEncoder.m
//  QYVideoEncoder
//
//  Created by Yuri Boyka on 2019/9/9.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "NSError+QYEncoder.h"
#import <VideoToolbox/VTErrors.h>

NSString * const VideoEncoderErrorDomain = @"VideoEncoderErrorDomain";
static NSString * DescriptionWithStatus(OSStatus status)
{
    switch(status)
    {
        case kVTPropertyNotSupportedErr:
            return @"Property Not Supported";
            
        default:
            return [NSString stringWithFormat:@"Video Toolbox Error: %d", (int)status];
    }
}

@implementation NSError (QYEncoder)

+ (instancetype)videoEncoderErrorWithStatus:(OSStatus)status
{
    return [NSError errorWithDomain:VideoEncoderErrorDomain code:status userInfo:@{
                                                                                   NSLocalizedDescriptionKey: DescriptionWithStatus(status),
                                                                                   }];
}
@end
