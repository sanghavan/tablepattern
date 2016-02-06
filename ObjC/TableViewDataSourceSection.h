//
//  TableViewDataSourceSection.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewCellModel.h"

@interface TableViewDataSourceSection : NSObject

@property(nonatomic, strong) id model;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(id)model;

- (NSUInteger)numberOfRows;
- (TableViewCellModel *)createCellModelAtRow:(NSUInteger)row;
- (void)didSelectRow:(NSUInteger)row
         inTableView:(UITableView *)tableView
    inViewController:(UIViewController *)viewController;

@end
