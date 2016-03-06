//
//  TableViewCell.h
//  Materik
//
//  Created by materik on 30/11/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewDataSource.h"
#import "TableViewDataSourceRow.h"
#import "TableViewDataSourceSection.h"

@interface TableViewCell : UITableViewCell

@property(nonatomic, readonly) TableViewDataSourceRow *dataSourceRow;
@property(nonatomic, readonly) TableViewDataSourceSection *dataSourceRowSection;
@property(nonatomic, readonly) TableViewDataSource *dataSource;

- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow;
- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
           inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection;
- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
           inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                  inDataSource:(TableViewDataSource *)dataSource;
+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow;
+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
               inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection;
+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
               inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                      inDataSource:(TableViewDataSource *)dataSource;
+ (instancetype)dequeueOrCreateReusableCellInDataSource:(TableViewDataSource *)dataSource;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
