//
//  Created by materik on 12/03/16.
//

#import <TablePattern/TablePattern.h>

@interface LoadingTableViewSection : TableViewSection

@property(nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)setLoading:(BOOL)loading inDataSource:(TableViewDataSource *)dataSource;

@end