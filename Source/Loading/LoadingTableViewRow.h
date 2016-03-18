//
//  Created by materik on 12/03/16.
//

#import <TablePattern/TablePattern.h>

@interface LoadingTableViewRow : TableViewRow

@property(nonatomic, assign, getter=isLoading) BOOL loading;
@property(nonatomic, assign) CGFloat size;
@property(nonatomic, assign) CGFloat padding;
@property(nonatomic, strong) UIColor *color;

@end
