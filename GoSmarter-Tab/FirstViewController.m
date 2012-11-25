//
//  FirstViewController.m
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *nameArray;
    NSMutableArray *imageArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [nameArray removeAllObjects];
    [imageArray removeAllObjects];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    nameArray = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];

    NSString *baseUrlString = @"http://gosmarter.net/gosmarter/searchpopular.do";
        
    NSLog(@"urlString - %@",baseUrlString);
    NSURL *url = [NSURL URLWithString:baseUrlString];
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
        NSString *name = [dictionary objectForKey:@"product"];
        NSString *imageUrl = [dictionary objectForKey:@"imageUrl"];
        
        NSLog(@"name and price - %@", name);
        
        [nameArray addObject:name];
        [imageArray addObject:imageUrl];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    int row = indexPath.row;
    
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", [nameArray objectAtIndex:row]];
    
    NSLog(@"in the pricearray %@", [imageArray objectAtIndex:row]);
    NSURL *imgURL=[[NSURL alloc]initWithString:[imageArray objectAtIndex:row]];
    
    NSData *imgdata=[[NSData alloc]initWithContentsOfURL:imgURL];
    
    UIImage *image=[[UIImage alloc]initWithData:imgdata];
    cell.imageView.image = image;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"in the prepareForSegue");

    SecondViewController *viewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
    
    viewController.onLoad = YES;
    viewController.searchString = [nameArray objectAtIndex:indexPath.row];
}

@end
