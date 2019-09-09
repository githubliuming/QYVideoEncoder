//
//  NSError+QYEncoder.h
//  QYVideoEncoder
//
//  Created by Yuri Boyka on 2019/9/9.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (QYEncoder)

+ (instancetype)videoEncoderErrorWithStatus:(OSStatus)status;

@end

NS_ASSUME_NONNULL_END
