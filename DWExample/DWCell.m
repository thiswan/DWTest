//
//  DWCell.m
//  DWExample
//
//  Created by Developer Wan on 16/11/10.
//  Copyright © 2016年 Developer Wan. All rights reserved.
//

#import "DWCell.h"
#import "DWModel.h"

@interface DWCell()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation DWCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.imageView = img;
        
        UILabel *lab = [[UILabel alloc] init];
        [self.contentView addSubview:lab];
        self.label = lab;
    }
    return self;
}

- (void)setModel:(DWModel *)model {
    _model = model;
    
    // 控件赋值
    self.imageView.image = [UIImage imageNamed:_model.icon];
    self.label.text = _model.title;
    
    // 子控件布局
    CGFloat screenWidth = self.contentView.frame.size.width;
    self.imageView.frame = CGRectMake(0, 0, screenWidth, 200);
    self.label.frame = CGRectMake(0, 0, screenWidth, 200);
    self.label.font = [UIFont systemFontOfSize:30];
    self.label.textAlignment = NSTextAlignmentCenter;
}
@end
