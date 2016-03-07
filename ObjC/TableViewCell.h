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

- (void)setupWithRow:(TableViewRow *)row;
- (void)setupWithRow:(TableViewRow *)row inSection:(TableViewSection *)section;
- (void)setupWithRow:(TableViewRow *)row
           inSection:(TableViewSection *)section
        inDataSource:(TableViewDataSource *)dataSource;
+ (CGFloat)heightWithRow:(TableViewRow *)row;
+ (CGFloat)heightWithRow:(TableViewRow *)row inSection:(TableViewSection *)section;
+ (CGFloat)heightWithRow:(TableViewRow *)row
               inSection:(TableViewSection *)section
            inDataSource:(TableViewDataSource *)dataSource;
+ (instancetype)dequeueOrCreateReusableCellInDataSource:(TableViewDataSource *)dataSource;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
