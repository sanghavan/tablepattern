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
@property(nonatomic, readonly) TableViewSection *section;
@property(nonatomic, readonly) TableViewDataSource *dataSource;

- (void)setupInRow:(TableViewRow *)row
         inSection:(TableViewSection *)section
      inDataSource:(TableViewDataSource *)dataSource;
+ (CGFloat)heightInRow:(TableViewRow *)row
             inSection:(TableViewSection *)section
          inDataSource:(TableViewDataSource *)dataSource;
+ (instancetype)dequeueOrCreateReusableCellInDataSource:(TableViewDataSource *)dataSource;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
