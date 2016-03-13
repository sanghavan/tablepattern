//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

#import "___FILEBASENAME___.h"

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - TableViewCell

- (void)setupInRow:(TableViewRow *)row
         inSection:(TableViewSection *)section
      inDataSource:(TableViewDataSource *)dataSource {
    [super setupInRow:row inSection:section inDataSource:dataSource];
    <#TODO: Setup your cell #>
}

// NOTE: Remove this method if you want to use the default value (44px)...
+ (CGFloat)heightInRow:(TableViewRow *)row
             inSection:(TableViewSection *)section
          inDataSource:(TableViewDataSource *)dataSource {
    return <#(CGFloat) #>;
}

@end
