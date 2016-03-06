//
//  TableViewDataSource.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSourceRow.h"
#import "TableViewDataSourceSection.h"

typedef void (^TableViewDataSourceLoadPaginatedDataCompletion)(BOOL hasMore);
typedef void (^TableViewDataSourceLoadDataCompletion)();

@protocol TableViewDataSourceParentViewController <NSObject>
@property(nonatomic, readonly) UITableView *tableView;
@end

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, strong) UIViewController<TableViewDataSourceParentViewController> *tableViewController;
@property(nonatomic, assign, getter=isPaginationEnabled) BOOL enablePagination;
@property(nonatomic, assign) NSUInteger paginationLimit;

- (void)resetData;
- (void)reloadData;
- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion;
- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion;

- (NSInteger)numberOfSections;
- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section;
- (TableViewDataSourceSection *)getDataSourceSectionInSection:(NSUInteger)section;
- (TableViewDataSourceRow *)getDataSourceRowAtIndexPath:(NSIndexPath *)indexPath;

@end
