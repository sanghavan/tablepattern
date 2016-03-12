//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

#import "___FILEBASENAME___.h"

@implementation ___FILEBASENAMEASIDENTIFIER___

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setEnablePagination:<#(BOOL) #>];
        [self setPaginationLimit:<#(NSUInteger) #>];
    }
    return self;
}

#pragma mark - TableViewDataSource

// NOTE: remove if you don't have any data to fetch, or if you support pagination
- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
    <#TODO : Load the data #>;
    completion();
}

// NOTE: remove if you don't have any data to fetch, or if you don't support pagination
- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    <#TODO : Load the data in(page) and (limit) #>;
    completion(NO);
}

- (TableViewSection *)createSectionAtIndex:(NSUInteger)index {
    return <#(TableViewSection *)#>;
}

- (NSUInteger)numberOfSections {
    return <#(NSUInteger) #>;
}

@end