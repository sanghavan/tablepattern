//
//  TableViewCellModel.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewCell;

@interface TableViewCellModel : NSObject

- (Class)cellClass;
- (CGFloat)heightFromTableView:(UITableView *)tableView;
- (TableViewCell *)dequeueOrCreateReusableCellFromTableView:(UITableView *)tableView;

@end
