//
//  SOPatternBGTableViewController.h
//  SOPatternBGTableViewController
//
//  Created by Stephen O'Connor on 9/18/12.
//  Copyright (c) 2012 Stephen O'Connor. All rights reserved.
//

/*
 
 So the idea here is workaround a limitation in the UITableView (due to the otherwise awesome queuing system) if you have a background that should scroll with the content, but it's built from a tiled pattern and therefore not be part of the cell itself.  If it's part of that table's background, it doesn't scroll.  If you wanted it to scroll with the content, you'd have to ensure that all your row heights are a multiple of the pattern image's height.  Sometimes this just isn't what you want.
 
 So the idea is to have two tables, where one is the slave of the other, and will resize itself according to the content.  This view controller demonstrates that.
 
 It should be that the frontTable can have dynamic height content, and backTable is a pattern of static row height that scrolls with it.
 
 In your subclass you should ensure that the self.frontTable property is set in either loadView, in a NIB/Storyboard, or BEFORE you call [super viewDidLoad].  The same is generally true for the backgroundPattern property.
 
 */


#import <UIKit/UIKit.h>

@interface SOPatternBGTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *frontTable;
@property (readonly, nonatomic) UITableView *backTable;  
@property (nonatomic, strong) UIImage *backgroundPattern;
@end
