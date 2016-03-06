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
@synthesize tableViewDataSource = _tableViewDataSource;

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

- (void)setTableViewDataSource:(TableViewDataSource *)tableViewDataSource {
    _tableViewDataSource = tableViewDataSource;
    [_tableViewDataSource setTableViewController:self];
    [self.tableView setDataSource:_tableViewDataSource];
    [self.tableView setDelegate:_tableViewDataSource];
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isFirstAppearance) {
        [self resetData];
        [self setFirstAppearance:NO];
    } else {
        [self.tableView reloadData];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:self.view.bounds];
}

#pragma mark - Action

- (void)resetData {
    [self.tableViewDataSource resetData];
}

- (void)reloadData {
    [self.tableViewDataSource reloadData];
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
