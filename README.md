UIImage-BRPixelsAdditions
=========================

Extension for UIImage adding some block based pixel modifications


## Create an image by modifying RGBA pixels of other

<pre>
- (UIImage*)br_imageByModifyingRGBApixelsUsingBlock:(void(^)(NSInteger idx, unsigned char *pixelStartAddr, BOOL *stop))block
</pre>

Returns a new UIImage by aplying a desired treatment of each pixel. For example, making a grayscaled version of an input image preserving the alpha:

<pre>
UIImage *img = [UIImage imageNamed:@"sample.png"];
UIImage *grayScaleImg = [img br_imageByModifyingRGBApixelsUsingBlock:^(NSInteger idx, unsigned char *pixelStartAddr, BOOL *stop) {
        
    unsigned char r, g, b, y;
    r = *(pixelStartAddr);
    g = *(pixelStartAddr + 1);
    b = *(pixelStartAddr + 2);
    
    //Grayscale formula: http://en.wikipedia.org/wiki/Grayscale
    y = 0.299 * r + 0.587 * g + 0.114 * b;
    
    *(pixelStartAddr) = y;
    *(pixelStartAddr + 1) = y;
    *(pixelStartAddr + 2) = y;
        
}];
</pre>

