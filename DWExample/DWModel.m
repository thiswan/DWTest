//
//  DWModel.m
//  DWExample
//
//  Created by Developer Wan on 16/11/10.
//  Copyright © 2016年 Developer Wan. All rights reserved.
//

#import "DWModel.h"

@implementation DWModel

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (id)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
