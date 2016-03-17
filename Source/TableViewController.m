//
//  TableViewController.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewController.h"

@interface TableViewController () <TableViewDataSourceParentViewController>

@property(nonatomic, assign, getter=isFirstAppearance) BOOL firstAppearance;

@end

@implementation TableViewController

@synthesize tableView = _tableView;
@synthesize dataSource = _dataSource;

- (instancetype)init {
    return [self initWithTableViewStyle:UITableViewStylePlain];
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle {
    self = [super init];
    if (self) {
        [self setFirstAppearance:YES];
        [self setTableViewStyle:tableViewStyle];
    }
    return self;
}

#pragma mark - Properties
#pragma mark Setter

- (void)setTableViewStyle:(UITableViewStyle)tableViewStyle {
    NSAssert(!self.tableView.superview, @"TableViewController: you can't change tableViewStyle after viewDidLoad");
    _tableViewStyle = tableViewStyle;
    _tableView = nil;
}

- (void)setDataSource:(TableViewDataSource *)dataSource {
    _dataSource = dataSource;
    [_dataSource setTableViewController:self];
    [self.tableView setDataSource:_dataSource];
    [self.tableView setDelegate:_dataSource];
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isFirstAppearance) {
        [self resetAndLoadData];
        [self setFirstAppearance:NO];
    } else {
        [self refreshData];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.bounds];
}

#pragma mark - Action

- (void)resetAndLoadData {
    [self.dataSource resetAndLoadDataOnCompletion:nil];
}

- (void)refreshData {
    [self.dataSource refreshDataOnCompletion:nil];
}

#pragma mark - Views

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

@end
