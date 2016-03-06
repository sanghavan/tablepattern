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
        FeedTableViewDataSource *dataSource = [[FeedTableViewDataSource alloc] init];
        [dataSource setPaginationLimit:2];
        [dataSource setEnablePagination:YES];
        [self setTableViewDataSource:dataSource];
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
      sharedInstance = [[FeedViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    });
    return sharedInstance;
}

@end
