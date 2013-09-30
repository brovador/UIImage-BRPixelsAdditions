//
//  UIImage+BRPixelAdditions.m
//  UIImagePixelsAdditions
//
//  Created by Jesús on 25/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import "UIImage+BRPixelAdditions.h"

@implementation UIImage (BRPixelAdditions)

- (UIImage*)br_imageByModifyingRGBApixelsUsingBlock:(void(^)(NSInteger idx, unsigned char *pixelStartAddr, BOOL *stop))block
{
    UIImage *result = nil;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    NSInteger bytesPerPixel = 4;
    NSInteger bitsPerComponent = 8;
    NSInteger bytesPerRow = imageWidth * bytesPerPixel;
    unsigned char *imgData = (unsigned char*)calloc(imageHeight * bytesPerRow, sizeof(unsigned char));
    CGContextRef context = CGBitmapContextCreate(imgData,
                                                 imageWidth,
                                                 imageHeight,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, (CGRect){.origin = CGPointZero, .size = self.size}, self.CGImage);
    
    BOOL stop = NO;
    for (NSInteger i = 0; i < imageHeight * imageWidth; i++) {
        block(i, &(imgData[i * 4]), &stop);
        if (stop) {
            break;
        }
    }
    
    CGImageRef resultCGImage = CGBitmapContextCreateImage(context);
    result = [[UIImage alloc] initWithCGImage:resultCGImage];
    
    
    CGImageRelease(resultCGImage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(imgData);
    
    return result;
}

@end
