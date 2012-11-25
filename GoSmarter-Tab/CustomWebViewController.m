//
//  CustomWebViewController.m
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import "CustomWebViewController.h"

@interface CustomWebViewController ()

@end

@implementation CustomWebViewController
@synthesize myWebview;
@synthesize link;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:url];
    [myWebview loadRequest:requestUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
