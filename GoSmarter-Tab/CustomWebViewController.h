//
//  CustomWebViewController.h
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebview;
@property (nonatomic, strong) NSString *link;
- (IBAction)backButton:(id)sender;

@end
