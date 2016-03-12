//
//  Created by materik on 12/03/16.
//

#import "LoadingTableViewSection.h"

#import "LoadingTableViewRow.h"

@implementation LoadingTableViewSection

- (void)setLoading:(BOOL)loading inDataSource:(TableViewDataSource *)dataSource {
    _loading = loading;
    [self setupRows];
}

- (NSUInteger)numberOfRows {
    return 1;
}

- (TableViewRow *)createRowAtIndex:(NSUInteger)index {
    LoadingTableViewRow *row = [[LoadingTableViewRow alloc] initWithObject:nil];
    [row setLoading:self.isLoading];
    return row;
}

@end