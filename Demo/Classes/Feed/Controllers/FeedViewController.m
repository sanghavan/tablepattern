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

- (instancetype)init {
    self = [super initWithTableViewStyle:UITableViewStyleGrouped];
    if (self) {
        [self setDataSource:[[FeedTableViewDataSource alloc] init]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Feed"];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

+ (FeedViewController *)sharedInstance {
    static dispatch_once_t onceToken;
    static FeedViewController *sharedInstance;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[FeedViewController alloc] init];
    });
    return sharedInstance;
}

@end
