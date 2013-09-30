//
//  UIImage+BRPixelAdditions.h
//  UIImagePixelsAdditions
//
//  Created by Jesús on 25/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BRPixelAdditions)

- (UIImage*)br_imageByModifyingRGBApixelsUsingBlock:(void(^)(NSInteger idx, unsigned char *pixelStartAddr, BOOL *stop))block;

@end
