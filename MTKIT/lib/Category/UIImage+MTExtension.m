//
//  UIImage+UIImage_G.m
//
//  Created by AlfieL on 14-5-5.
//  Copyright (c) 2014年 Maitian. All rights reserved.
//
#import "objc/runtime.h"

@implementation UIImage (MTExtentsion)

+ (UIImage *)resizeImageWithImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return  [image stretchableImageWithLeftCapWidth:image.size.width * 0.5  topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)resizeImageWithImageName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage*)imageWithColor:(UIImage*)image COLOR:(UIColor *)color
{
    UIImage* ret = image;
    
    if(ret)
    {
        CGRect rect = CGRectMake(0, 0, ret.size.width, ret.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, ret.scale);
        CGContextRef c = UIGraphicsGetCurrentContext();
        [ret drawInRect:rect];
        CGContextSetFillColorWithColor(c, [color CGColor]);
        CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
        CGContextFillRect(c, rect);
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        ret = result;
    }
    
    return ret;
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color
{
    UIImage* ret = [UIImage imageNamed:name];
    
    if(ret)
    {
        CGRect rect = CGRectMake(0, 0, ret.size.width, ret.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, ret.scale);
        CGContextRef c = UIGraphicsGetCurrentContext();
        [ret drawInRect:rect];
        CGContextSetFillColorWithColor(c, [color CGColor]);
        CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
        CGContextFillRect(c, rect);
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        ret = result;
    }
    
    return ret;
}

- (UIImage *)changeImageColor:(UIColor *)color
{
    if (color)
    {
        return [UIImage imageWithColor:self COLOR:color];
    }
    
    return nil;
}

+ (UIImage *)resizeImageWithImageName:(NSString *)name left:(CGFloat)left top:(CGFloat)top changeColor:(UIColor *)color
{
    UIImage *resizeImage;
    if (name)
    {
        resizeImage = [UIImage resizeImageWithImageName:name left:left top:top];
        if (resizeImage)
        {
            resizeImage = [UIImage imageWithColor:resizeImage COLOR:color];
        }
    }
    return resizeImage;
}

- (UIImage *)resizeImageleft:(CGFloat)left top:(CGFloat)top
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}

+ (NSData *)imageDataWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

+ (UIImage *)resizeImageWithImage:(UIImage *)image scale:(float)scale
{
    CGSize newSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)resizeImageWithNewSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio < 1 && horizontalRadio<1)
    {
        radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)clearColor
{
    return [self grayscale:self type:1];
}

- (UIImage*)grayscale:(UIImage*)anImage type:(int)type {
    
    CGImageRef imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(effectedImage.size.width, effectedImage.size.height));
    [effectedImage drawInRect:CGRectMake(0, 0, effectedImage.size.width, effectedImage.size.height)];
    effectedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
    
}

- (NSString *)getQRCodeString
{
    NSDictionary *detectorOptions = @{CIDetectorAccuracy: CIDetectorAccuracyHigh};
    CIDetector *detector = [CIDetector  detectorOfType:CIDetectorTypeQRCode context:nil options:detectorOptions];
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    if (detector)  {
        NSArray* featuresR = [detector featuresInImage:ciImage];
        NSString* decodeR;
        for (CIQRCodeFeature* featureR in featuresR)  {
            decodeR = featureR.messageString;
        }
        return decodeR;
    }
    return  nil;
}

- (BOOL)validQRCode
{
    if ([self getQRCodeString]) {
        return true;
    }
    return false;
}

@end
