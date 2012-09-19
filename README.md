SOPatternBGTableViewController
==============================

This View Controller allows you to provide a pattern image as a moveable background that scrolls with your content (e.g a UIScrollView or UITableView)  with that scroll view's content, which (if a tableView) could have row heights that are not a multiple of your desired background tile size.


Installation and Usage
======================

* Import the SOPatternBGTableViewController folder into your project.
* Subclass the SOPatternBGTableViewController and be sure to set the self.masterScrollView property in your loadView / NIB / Storyboard, OR before you call [super viewDidLoad]
* The same applies for the self.backgroundPattern property although could likely be changed later.  (Hasn't been really tested though)
* Then use the class as you normally would use a UIViewController. 

About this Implementation
=========================

So the idea here is to workaround a limitation in the UITableView (due to the otherwise awesome queuing system) if you have a background that should scroll with the content, but it's built from a tiled pattern and therefore not be part of the cell itself.  If it's part of that table's background, it doesn't scroll.  If you wanted it to scroll with the content, you'd have to ensure that all your row heights are a multiple of the pattern image's height.  Sometimes this just isn't what you want.
 
So the idea is to have two scrollable view, where one is the slave of the other, and will resize itself according to the content.  This view controller demonstrates that.
 
It should be that the masterScrollView can have dynamic height content, and backTable is a pattern of static row height that scrolls with it.
 
In your subclass you should ensure that the self.masterScrollView property is set in either loadView, in a NIB/Storyboard, or BEFORE you call [super viewDidLoad].  The same is generally true for the backgroundPattern property.
 
