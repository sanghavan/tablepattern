//
//  FeedItem.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedItem.h"

@implementation FeedItem

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc {
    self = [super init];
    if (self) {
        _title = title;
        _desc = desc;
    }
    return self;
}

@end
