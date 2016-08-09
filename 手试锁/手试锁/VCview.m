//
//  VCview.m
//  手试锁
//
//  Created by niuwan on 16/7/25.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "VCview.h"

@implementation VCview


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIImage *image = [UIImage imageNamed: @"Home_refresh_bg"];
    
    [image drawInRect:rect];
}


@end
