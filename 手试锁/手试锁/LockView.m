//
//  LockView.m
//  手试锁
//
//  Created by niuwan on 16/7/25.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, assign) CGPoint curP;

@property (nonatomic, strong) NSMutableArray *selectedsBtn;

@end

@implementation LockView

- (NSMutableArray *)selectedsBtn {
    
    if (!_selectedsBtn) {
        _selectedsBtn = [NSMutableArray array];
    }
    return _selectedsBtn;
}

- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    //获取触摸点
    _curP = [pan locationInView:self];
    
    //判断触摸点在不在按钮上
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, _curP) && btn.selected == NO) {
            //点在按钮上
            btn.selected = YES;
            
            //保存到数组
            [self.selectedsBtn addObject:btn];
        }
    }
    
    //重绘
    [self setNeedsDisplay];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //创建可变字符串
        NSMutableString *strM = [NSMutableString string];
        
        //保存输入的密码
        
        for (UIButton *btn in self.selectedsBtn) {
            [strM appendFormat:@"%ld", btn.tag];
        }
        
        NSLog(@"密码:%@", strM);
        
        //还原界面
        
        //取消所有的选中按钮
//        [self.selectedsBtn makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
        
        
        for (UIButton *btn in self.selectedsBtn) {
            [btn setSelected:NO];
        }
        
        
        //清楚画线，把选中按钮清空
        [self.selectedsBtn removeAllObjects];
    }
    
}

- (void)awakeFromNib {

    // 创建9个按钮
    for ( int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.userInteractionEnabled = NO;
        
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.tag = i;
        
        [self addSubview:btn];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSInteger count = self.subviews.count;

    int cols = 3;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 74;
    CGFloat h = 74;
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);
    
    CGFloat col = 0;
    CGFloat row = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = margin + col * (margin + w);
        y = row * (margin + h);
        
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    
}


- (void)drawRect:(CGRect)rect {
    
    //如果没有选择的按钮不需要重绘
    if (self.selectedsBtn.count == 0) return;
    
    //所有选中的按钮的中心点连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSInteger count = self.selectedsBtn.count;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.selectedsBtn[i];
        if (i == 0) {
            //设置起点
            [path moveToPoint:btn.center];
        }else {
        
            [path addLineToPoint:btn.center];
        }
    }
    
    //连接到手指的触摸点
    [path addLineToPoint:_curP];
    
    [[UIColor greenColor] set];
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
    
    
}


@end
