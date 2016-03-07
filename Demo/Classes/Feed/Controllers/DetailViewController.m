//
//  DetailViewController.m
//  ObjCDemo
//
//  Created by materik on 29/02/16.
//
//

#import "DetailViewController.h"

@implementation DetailViewController

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        [self setTitle:title];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:self.title];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

@end
