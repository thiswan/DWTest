//
//  DWModel.h
//  DWExample
//
//  Created by Developer Wan on 16/11/10.
//  Copyright © 2016年 Developer Wan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

-(id)initWithDict:(NSDictionary *)dict;
+(id)modelWithDict:(NSDictionary *)dict;

@end
