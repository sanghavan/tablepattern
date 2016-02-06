//
//  TableViewDataSourceSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewDataSourceSection.h"

@implementation TableViewDataSourceSection

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        [self setModel:model];
    }
    return self;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"need to be implemented by subclass");
    return 0;
}

- (TableViewCellModel *)createCellModelAtRow:(NSUInteger)row {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

- (void)didSelectRow:(NSUInteger)row
         inTableView:(UITableView *)tableView
    inViewController:(UIViewController *)viewController {
    // Do nothing...
}

@end
