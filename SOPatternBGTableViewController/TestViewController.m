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
    
    // we change colors just to demonstrate that you have 2 tableviews running, each with their own background heights.
    
    if (tableView == self.frontTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
        
        if (isOdd) {
            [[cell viewWithTag:10] setBackgroundColor: [UIColor purpleColor]];
        }
        else
        {
            [[cell viewWithTag:10] setBackgroundColor: [UIColor cyanColor]];
        }
        
        return cell;
    }

    // handle backTable
    return [super tableView:tableView cellForRowAtIndexPath: indexPath];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // this bit should really be set in subclass.
    if (tableView == self.frontTable) {
        return 1;
    }
    
    // handle backTable
    return [super numberOfSectionsInTableView: tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // generate some random height
    return  82 - 15 + arc4random()%30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.frontTable) {
        return 100;
    }
    
    // handle backTable
    return [super tableView:tableView numberOfRowsInSection:section];
}




@end
