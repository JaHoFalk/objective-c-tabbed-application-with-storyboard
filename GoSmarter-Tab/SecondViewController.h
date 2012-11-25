//
//  SecondViewController.h
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "CustomWebViewController.h"

@interface SecondViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic) BOOL onLoad;
@property (weak, nonatomic) NSString* searchString;

-(void)loadData: (NSString *)searchString;

@end
