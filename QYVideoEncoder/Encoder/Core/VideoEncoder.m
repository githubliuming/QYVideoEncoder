//
//  VideoEncoder.m
//  QYVideoEncoder
//
//  Created by Yuri Boyka on 2019/9/9.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "VideoEncoder.h"
#import "NSError+QYEncoder.h"
@implementation VideoEncoderConfig

@end
@interface VideoEncoder()
{
@protected
    VTCompressionSessionRef compressionSession;
    VideoEncoderConfig * _config;
}

@end
@implementation VideoEncoder

- (instancetype)initWithConfig:(VideoEncoderConfig *)config error:(NSError **)error;
{
    self = [super init];
    if(self)
    {
        OSStatus stauts = VTCompressionSessionCreate(NULL,
                                                     config.width,
                                                     config.height,
                                                     config.type,
                                                     (__bridge CFDictionaryRef)@{},
                                                     ( __bridge CFDictionaryRef)config.sourceImageBufferAttributes,
                                                     NULL,
                                                     VideoCompressonOutputCallback,
                                                     (__bridge void *)self,
                                                     &compressionSession);
        if(stauts != noErr)
        {
            *error =  [NSError videoEncoderErrorWithStatus:stauts];
            NSLog(@"init VTCompressionSessionCreate error %@",*error);
            return nil;
        }
        _config = config;
        
    }
    return self;
}
- (CVPixelBufferPoolRef)pixelBufferPool
{
    return VTCompressionSessionGetPixelBufferPool(compressionSession);
}

//- (NSError *)initConfig
//{
//    NSError * error;
//    _config.propertyDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        
////        [self ]
//    }
//    return error;
//}
- (id)valueForProperty:(NSString *)property error:(NSError **)outError
{
    CFTypeRef value = NULL;
    OSStatus status = VTSessionCopyProperty(compressionSession, (__bridge CFStringRef)property, NULL, &value);
    if(status != noErr)
    {
        NSError *error = [NSError videoEncoderErrorWithStatus:status];
        if(outError != nil)
        {
            *outError = error;
        }
        else
        {
            NSLog(@"%s:%d: %@", __FUNCTION__, __LINE__, error);
        }
        
        return nil;
    }
    
    return CFBridgingRelease(value);
}
- (BOOL)setValue:(id)value forProperty:(NSString *)property error:(NSError **)outError
{
    OSStatus status = VTSessionSetProperty(compressionSession, (__bridge CFStringRef)property, (__bridge CFTypeRef)value);
    if(status != noErr)
    {
        NSError *error = [NSError videoEncoderErrorWithStatus:status];
        if(outError != nil)
        {
            *outError = error;
        }
        else
        {
            NSLog(@"%s:%d: %@", __FUNCTION__, __LINE__, error);
        }
        
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
    if(compressionSession != NULL)
    {
        VTCompressionSessionInvalidate(compressionSession);
    }
}

static void VideoCompressonOutputCallback(void *VTref, void *VTFrameRef, OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef sampleBuffer)
{
    //    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)VTFrameRef;
    //    CVPixelBufferRelease(pixelBuffer); // see encodeFrame:
    //    pixelBuffer = NULL;
    
    VideoEncoder *compressionSession = (__bridge VideoEncoder *)VTref;
//    [compressionSession encodePixelBufferCallbackWithSampleBuffer:sampleBuffer infoFlags:infoFlags];
}

@end
