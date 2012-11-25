//
//  SecondViewController.m
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () {
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *nameArray;
    NSMutableArray *priceArray;
    NSMutableArray *imageArray;
    NSMutableArray *linkArray;
}

@end

@implementation SecondViewController

@synthesize onLoad;
@synthesize searchString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    nameArray = [[NSMutableArray alloc]init];
    priceArray = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    linkArray = [[NSMutableArray alloc]init];
    
    if(onLoad){
        [self loadData:searchString];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSArray *arrayOfEntry = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    
    for (NSDictionary *dictionary in arrayOfEntry) {
        NSString *name = [dictionary objectForKey:@"name"];
        NSNumber *price = [dictionary objectForKey:@"price"];
        NSString *imageUrl = [dictionary objectForKey:@"imageUrl"];
        NSString *link = [dictionary objectForKey:@"link"];
        
        NSLog(@"name and price - %@, %@", name, price);
        
        [nameArray addObject:name];
        [priceArray addObject:price];
        [imageArray addObject:imageUrl];
        [linkArray addObject:link];
    }
    
    [[self myTableView]reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    int row = indexPath.row;
    
    cell.label1.text = [NSString stringWithFormat:@"Name: %@", [nameArray objectAtIndex:row]];
    NSLog(@"in the pricearray %@", [priceArray objectAtIndex:row]);
    cell.label2.text = [NSString stringWithFormat:@"Price: %@", [priceArray objectAtIndex:row]];
    
    NSLog(@"in the pricearray %@", [imageArray objectAtIndex:row]);
    NSURL *imgURL=[[NSURL alloc]initWithString:[imageArray objectAtIndex:row]];
    
    NSData *imgdata=[[NSData alloc]initWithContentsOfURL:imgURL];
    
    UIImage *image=[[UIImage alloc]initWithData:imgdata];
    cell.imageView.image = image;
    
    return cell;
}

-(void)loadData: (NSString *)searchString {
    
    [nameArray removeAllObjects];
    [priceArray removeAllObjects];
    [imageArray removeAllObjects];
    [linkArray removeAllObjects];
    
    NSString *baseUrlString = @"http://gosmarter.net/gosmarter/searchwall.do?query=";
    
    NSString* escapedUrlString = [searchString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSString *urlString = [baseUrlString stringByAppendingString:escapedUrlString];
    
    NSLog(@"urlString - %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url - %@",url);
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSLog(@"request - %@",request);
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"connection - %@",connection);
    
    if(connection){
        webData = [[NSMutableData alloc]init];
    }
    [self.myTableView resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchQuery = searchBar.text;
    [self loadData:searchQuery];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CustomWebViewController *viewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
    
    viewController.link = [linkArray objectAtIndex:indexPath.row];
    NSLog(@"viewController=%@", viewController.link);
}

@end
