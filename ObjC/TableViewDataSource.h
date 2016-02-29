//
//  TableViewDataSource.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSourceRow.h"
#import "TableViewDataSourceSection.h"

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIViewController *parentViewController;

- (void)reloadDataInTableView:(UITableView *)tableView;
- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section;
- (TableViewDataSourceSection *)getDataSourceSectionInSection:(NSUInteger)section;
- (TableViewDataSourceRow *)getDataSourceRowAtIndexPath:(NSIndexPath *)indexPath;

@end
