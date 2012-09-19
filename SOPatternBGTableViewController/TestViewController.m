//
//  TestViewController.m
//  DoubleTable
//
//  Created by Stephen O'Connor on 9/19/12.
//  Copyright (c) 2012 Stephen O'Connor. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

- (void)viewDidLoad
{
    // important to set this before calling SUPER!  
    self.backgroundPattern = [UIImage imageNamed:@"background_tile.png"];

    [super viewDidLoad];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    BOOL isOdd = (BOOL)(indexPath.row % 2);
    
    // we change colors just to show the different rows.
    
    if (tableView == self.frontTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
        
        if (isOdd) {
            // check the prototype cell defined in the storyboard
            [[cell viewWithTag:10] setBackgroundColor: [UIColor purpleColor]];
        }
        else
        {
            [[cell viewWithTag:10] setBackgroundColor: [UIColor cyanColor]];
        }
        
        
    }

    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // this bit should really be set in subclass.
    if (tableView == self.frontTable) {
        return 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // generate some random height.  Note the viewWithTag: 10 in the prototype cell is not set to autoresize its height so that you can see gaps in the cells (so to see the background table)
    return  82 + (indexPath.row * 5) % 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.frontTable) {
        return 100;
    }
    
    return 0;
}




@end
