
//
//  SOPatternBGTableViewController.m
//  SOPatternBGTableViewController
//
//  Created by Stephen O'Connor on 9/18/12.
//  Copyright (c) 2012 Stephen O'Connor. All rights reserved.
//


#import "SOPatternBGTableViewController.h"

// that means that compared to your frontTable, your backTable's frame should be -200 and +400 in y and height, respectively.  THIS IS IMPORTANT that you have this correct in your XIB or otherwise.  This is to ensure that the background is always scrolling

// if you haven't redefined elsewhere...
#ifndef BACK_TABLE_OUTER_MARGIN
#define BACK_TABLE_OUTER_MARGIN 200
#endif


// THIS JUST A PRIVATE CLASS USED FOR OBSERVING
@interface SOBackingTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
{
    UIImage *_backgroundPattern;
}
@property (nonatomic, strong) UIImage *backgroundPattern;
@property (nonatomic, weak) UITableView *frontTable;
@end

@implementation SOBackingTableView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self reloadData];  // front table's contentSize has changed, so we have to trigger a reload in our table to recalculate the number of rows required to fit the frontTable's new contentSize.
    }
    else if ([keyPath isEqualToString:@"contentOffset"])
    {
        // this just ensures the backTable is scrolling together with the front table
        UITableView *front = (UITableView*)object;
        self.contentOffset = front.contentOffset;
    }
}

- (UIImage*)backgroundPattern { return _backgroundPattern;}
- (void)setBackgroundPattern:(UIImage *)backgroundPattern
{
    _backgroundPattern = backgroundPattern;
    [self reloadData];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (tableView == self){
        cell = [tableView dequeueReusableCellWithIdentifier:@"PatternBGCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatternBGCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        UIColor *bgColor;
        if (self.backgroundPattern) {
            bgColor = [UIColor colorWithPatternImage: self.backgroundPattern];
        }
        else
        {
            bgColor = [UIColor grayColor];
        }
        cell.contentView.backgroundColor = bgColor;
    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self){
        
        // number of rows we'd need to be enough to fit behind the frontTable's content, and if that content is not enough to fill the screen we make sure the backing table will fill the screen.
        NSInteger numRows = ceilf(MAX(self.frontTable.contentSize.height, self.frontTable.bounds.size.height)/self.rowHeight);
        
        // now figure out how many rows it would take to fill the table margins.  right now we prototyped 200 above and below the front table
        numRows += ceilf(2*BACK_TABLE_OUTER_MARGIN/self.rowHeight);
        
        return numRows;
    }
    return 0;
}

@end






@interface SOPatternBGTableViewController ()
{
    UIImage *_backgroundPattern;
}
@end

@implementation SOPatternBGTableViewController

- (UIImage*)backgroundPattern { return _backgroundPattern;}
- (void)setBackgroundPattern:(UIImage *)backgroundPattern
{
    _backgroundPattern = backgroundPattern;
}


- (void)setupBackTable
{
    NSAssert(self.frontTable != nil, @"You need to set the frontTable property in your NIB or your loadView method if you want to use this class!");
    CGRect newFrame = self.frontTable.bounds;
    newFrame.origin.y -= BACK_TABLE_OUTER_MARGIN;
    newFrame.size.height += 2*BACK_TABLE_OUTER_MARGIN;
    
    _backTable = [[SOBackingTableView alloc] initWithFrame:newFrame
                                                     style:UITableViewStylePlain];
    // further backTable config
    _backTable.userInteractionEnabled = NO;
    _backTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _backTable.showsHorizontalScrollIndicator = NO;
    _backTable.showsVerticalScrollIndicator = NO;
    _backTable.scrollsToTop = NO;  // important to prevent conflicts

    
    // if image is defined, set rowHeight to something that is a multiple of imageHeight.  I just picked 64.0 arbitrarily, thinking too many cells could be expensive, and too few could be a lot of content rendered off screen.
    CGFloat rowHeight = 0;
    if (self.backgroundPattern) {
        while (rowHeight < 64) {
            rowHeight += self.backgroundPattern.size.height;
        }
    }
    else
        rowHeight = 64.0f;
    
    ((SOBackingTableView*)_backTable).frontTable = self.frontTable;
    _backTable.rowHeight = rowHeight;
    _backTable.dataSource = (SOBackingTableView*)_backTable;
    _backTable.delegate = (SOBackingTableView*)_backTable;
    
    ((SOBackingTableView*)_backTable).backgroundPattern = self.backgroundPattern;
    
    [self.view insertSubview: _backTable atIndex:0];
    
    
    // make the backTable listen to changes in frontTable's contentSize (i.e. if the contentChanges)
    [self.frontTable addObserver: _backTable
                      forKeyPath: @"contentSize"
                         options:NSKeyValueObservingOptionNew context:nil];

    [self.frontTable addObserver: _backTable
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupBackTable];
    
}


@end
