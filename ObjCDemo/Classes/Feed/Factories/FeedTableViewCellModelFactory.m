//
//  FeedTableViewCellModelFactory.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewCellModelFactory.h"

#import "FeedTitleTableViewCellModel.h"

@implementation FeedTableViewCellModelFactory

+ (TableViewCellModel *)createTitleCellModelFromItem:(FeedItem *)item {
    FeedTitleTableViewCellModel *cellModel = [[FeedTitleTableViewCellModel alloc] init];
    [cellModel setText:item.title];
    return cellModel;
}

+ (TableViewCellModel *)createDescCellModelFromItem:(FeedItem *)item {
    FeedTitleTableViewCellModel *cellModel = [[FeedTitleTableViewCellModel alloc] init];
    [cellModel setText:item.desc];
    return cellModel;
}

@end
