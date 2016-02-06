//
//  TableViewCellModel.m
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewCellModel.h"

#import "TableViewCell.h"

@implementation TableViewCellModel

- (Class)cellClass {
    NSString *className = NSStringFromClass([self class]);
    className = [className stringByReplacingOccurrencesOfString:@"Model" withString:@""];
    return NSClassFromString(className);
}

- (CGFloat)heightFromTableView:(UITableView *)tableView {
    if ([self.cellClass isSubclassOfClass:[TableViewCell class]]) {
        return [self.cellClass heightWithModel:self fromTableView:tableView];
    }
    NSAssert(NO, @"need to be implemented by subclass");
    return 0.0f;
}

- (TableViewCell *)dequeueOrCreateReusableCellFromTableView:(UITableView *)tableView {
    if ([self.cellClass isSubclassOfClass:[TableViewCell class]]) {
        TableViewCell *cell = [self.cellClass dequeueOrCreateReusableCellFromTableView:tableView];
        [cell setModel:self];
        return cell;
    }
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

@end
