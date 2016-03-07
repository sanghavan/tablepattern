//
//  FeedItem.h
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property(nonatomic, readonly) NSString *title;
@property(nonatomic, readonly) NSString *desc;

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc;

@end
