//
//  FirstViewController.h
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface FirstViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
