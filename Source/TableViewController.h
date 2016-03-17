//
//  TableViewController.h
//
//  Created by materik on 11/12/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewController : UIViewController

@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, strong) TableViewDataSource *dataSource;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
