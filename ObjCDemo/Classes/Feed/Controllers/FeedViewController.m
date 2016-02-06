//
//  FeedViewController.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedViewController.h"

#import "FeedTableViewDataSource.h"

@implementation FeedViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style {
    self = [super initWithTableViewStyle:style];
    if (self) {
        [self setDataSource:[[FeedTableViewDataSource alloc] init]];
    }
    return self;
}

+ (FeedViewController *)sharedInstance {
    static dispatch_once_t onceToken;
    static FeedViewController *sharedInstance;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[FeedViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    });
    return sharedInstance;
}

@end
