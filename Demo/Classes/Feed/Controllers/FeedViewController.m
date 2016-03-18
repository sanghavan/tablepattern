//
//  FeedViewController.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedViewController.h"

#import "FeedTableViewDataSource.h"

@interface FeedViewController ()

@property(nonatomic, readonly) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

@synthesize refreshControl = _refreshControl;

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
    [self.tableView addSubview:self.refreshControl];
}

- (void)resetData {
    [self.dataSource resetAndLoadDataOnCompletion:^{
      [self.refreshControl endRefreshing];
    }];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(resetData) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
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
