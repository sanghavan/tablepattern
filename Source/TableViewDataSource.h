//
//  TableViewDataSource.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewRow.h"
#import "TableViewSection.h"

typedef void (^TableViewDataSourceLoadPaginatedDataCompletion)(BOOL hasMore);
typedef void (^TableViewDataSourceLoadDataCompletion)();
typedef void (^TableViewDataSourceReloadDataCompletion)();

@protocol TableViewDataSourceParentViewController <NSObject>
@property(nonatomic, readonly) UITableView *tableView;
@end

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIViewController<TableViewDataSourceParentViewController> *tableViewController;
@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, readonly) NSUInteger numberOfSections;

@property(nonatomic, assign, getter=isLoading) BOOL loading;
@property(nonatomic, assign, getter=isLoadingIndicatorEnabled) BOOL enableLoadingIndicator;
@property(nonatomic, assign) CGFloat loadingIndicatorSize;
@property(nonatomic, assign) CGFloat loadingIndicatorPadding;
@property(nonatomic, strong) UIColor *loadingIndicatorColor;

@property(nonatomic, assign, getter=isPaginationEnabled) BOOL enablePagination;
@property(nonatomic, assign) NSUInteger paginationPage;
@property(nonatomic, assign) NSUInteger paginationLimit;

- (void)resetAndLoadDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion;
- (void)refreshDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion;
- (void)fetchDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion;
- (void)fetchDataOnPage:(NSUInteger)page
              withLimit:(NSUInteger)limit
           onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion;

- (TableViewSection *)createSectionAtIndex:(NSUInteger)index;
- (TableViewSection *)getSectionAtIndex:(NSUInteger)index;
- (TableViewRow *)getRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Static

+ (void)setLoadingIndicatorSize:(CGFloat)size;
+ (void)setLoadingIndicatorPadding:(CGFloat)padding;
+ (void)setLoadingIndicatorColor:(UIColor *)color;

@end
