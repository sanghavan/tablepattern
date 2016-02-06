//
//  FeedTableViewCellModelFactory.h
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import <TableViewDataSourceDesignPattern/TableViewDataSourceDesignPattern.h>

#import "FeedItem.h"

@interface FeedTableViewCellModelFactory : NSObject

- (TableViewCellModel *)createTitleCellModelFromItem:(FeedItem *)item;
- (TableViewCellModel *)createDescCellModelFromItem:(FeedItem *)item;

@end
