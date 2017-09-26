//
//  NSString+MTRandom.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/7/17.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "NSString+MTRandom.h"

@implementation NSString (MTRandom)

-(NSString *)randomStringWithLength:(NSInteger)len {

    return [self randomStringWithLength:len];

}

+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"历想为官日无如刺史时欢娱接宾客饱暖及妻儿自到东都后安闲更得宜分司胜刺史致仕胜分司何况园林下欣然得朗之仰名同旧识为乐即新知有雪先相访无花不作期斗醲干酿酒夸妙细吟诗里巷千来往都门五别离岐分两回首书到一开眉叶落槐亭院冰生竹阁池雀罗谁问讯鹤氅罢追随身与心俱病容将力共衰老来多健忘唯不忘相思";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (NSInteger i = 0; i < len; i++) {
        NSRange range = NSMakeRange(arc4random()%letters.length, 1);
        [randomString appendFormat:@"%@",[letters substringWithRange:range]];
    }
    return randomString;
}

@end
