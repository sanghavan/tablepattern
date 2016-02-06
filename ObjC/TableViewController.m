//
//  TableViewController.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewController.h"

@interface TableViewController ()

@property(nonatomic, assign, getter=isFirstAppearance) BOOL firstAppearance;

@end

@implementation TableViewController

@synthesize tableView = _tableView;
@synthesize dataSource = _dataSource;

- (instancetype)init {
    return [self initWithTableViewStyle:UITableViewStylePlain];
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        [self setFirstAppearance:YES];
        [self setStyle:style];
    }
    return self;
}

#pragma mark - Properties
#pragma mark Setter

- (void)setStyle:(UITableViewStyle)style {
    _style = style;
    _tableView = nil;
}

- (void)setDataSource:(TableViewDataSource *)dataSource {
    _dataSource = dataSource;
    [_dataSource setParentViewController:self];
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
        [self reloadData];
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

- (void)reloadData {
    [self.dataSource reloadDataInTableView:self.tableView];
}

#pragma mark - Views

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

@end
