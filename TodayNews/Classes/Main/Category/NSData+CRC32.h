//
//  NSData+CRC32.h
//  TodayNews
//
//  Created by 郭振礼 on 2017/11/13.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>

@interface NSData (CRC32)
-(int32_t) crc_32;

-(uLong)getCRC32;
@end
