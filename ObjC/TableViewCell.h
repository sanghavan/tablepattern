//
//  TableViewCell.h
//  Materik
//
//  Created by materik on 30/11/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewDataSource.h"
#import "TableViewRow.h"
#import "TableViewSection.h"

@interface TableViewCell : UITableViewCell

@property(nonatomic, readonly) TableViewRow *row;
@property(nonatomic, readonly) TableViewSection *rowSection;
@property(nonatomic, readonly) TableViewDataSource *dataSource;

- (void)setupOfCellWithRow:(TableViewRow *)row;
- (void)setupOfCellWithRow:(TableViewRow *)row inSection:(TableViewSection *)section;
- (void)setupOfCellWithRow:(TableViewRow *)row
                 inSection:(TableViewSection *)section
              inDataSource:(TableViewDataSource *)dataSource;
+ (CGFloat)heightOfCellWithRow:(TableViewRow *)row;
+ (CGFloat)heightOfCellWithRow:(TableViewRow *)row inSection:(TableViewSection *)section;
+ (CGFloat)heightOfCellWithRow:(TableViewRow *)row
                     inSection:(TableViewSection *)section
                  inDataSource:(TableViewDataSource *)dataSource;
+ (instancetype)dequeueOrCreateReusableCellInDataSource:(TableViewDataSource *)dataSource;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
