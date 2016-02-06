//
//  TableViewDataSource.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSourceSection.h"

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIViewController *parentViewController;

- (void)reloadDataInTableView:(UITableView *)tableView;
- (void)childViewController:(UIViewController *)childViewController atIndexPath:(NSIndexPath *)indexPath;
- (TableViewDataSourceSection *)createSectionInSection:(NSUInteger)section;
- (TableViewDataSourceSection *)getSectionInSection:(NSUInteger)section;

@end
