SOPatternBGTableViewController
==============================

This Table View Controller allows you to provide a pattern image that scrolls with your content (originally designed for a TableView although could equally work with a UIScrollView)  with the table view's content, which could have row heights that are not a multiple of your desired backgroundt tile size.


Installation and Usage
======================

* Import the SOPatternBGTableViewController folder into your project.
* Subclass the SOPatternBGTableViewController and be sure to set the self.frontTable property in your loadView / NIB / Storyboard, OR before you call [super viewDidLoad]
* The same applies for the self.backgroundPattern property although could likely be changed later.  (Hasn't been really tested though)
* Then use the class as you normally would use a UIViewController.  Implement delegate/dataSource as you typically would for the self.frontTable property.

About this Implementation
=========================

So the idea here is workaround a limitation in the UITableView (due to the otherwise awesome queuing system) if you have a background that should scroll with the content, but it's built from a tiled pattern and therefore not be part of the cell itself.  If it's part of that table's background, it doesn't scroll.  If you wanted it to scroll with the content, you'd have to ensure that all your row heights are a multiple of the pattern image's height.  Sometimes this just isn't what you want.
 
So the idea is to have two tables, where one is the slave of the other, and will resize itself according to the content.  This view controller demonstrates that.
 
It should be that the frontTable can have dynamic height content, and backTable is a pattern of static row height that scrolls with it.
 
In your subclass you should ensure that the self.frontTable property is set in either loadView, in a NIB/Storyboard, or BEFORE you call [super viewDidLoad].  The same is generally true for the backgroundPattern property.
 
