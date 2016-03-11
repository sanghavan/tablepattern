//
//  FeedTableViewSection.h
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import <TablePattern/TablePattern.h>

#import "FeedItem.h"

@interface FeedTableViewSection : TableViewSection <FeedItem *>

- (void)toggleHideDescriptionInDataSource:(TableViewDataSource *)dataSource;

@end
