//
//  BoxScoreMasterViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 3/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BoxScoreMasterViewController.h"
#import "BoxScoreDetailViewController.h"
#import "GameDataController.h"

@interface BoxScoreMasterViewController ()

@end

@implementation BoxScoreMasterViewController

@synthesize tableList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableList = [[NSMutableArray alloc] initWithObjects:@"Number 1", @"Number 2", @"Number 3", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GameDataController* s = [GameDataController sharedInstance];
    // Return the number of rows in the section.
    return s.BoxScoreList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameDataController* s = [GameDataController sharedInstance];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *t = [[NSMutableArray alloc] init];
    t = [s.BoxScoreList objectAtIndex:indexPath.row];
    cell.textLabel.text = [t objectAtIndex:0];
    //cell.textLabel.text = [tableList objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Create instance of DetailViewController
    BoxScoreDetailViewController *DVC = [[BoxScoreDetailViewController alloc] init];
    
    //Set the DetailViewController to the DestinationViewController
    DVC = [segue destinationViewController];
    
    //Get the index path
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    //NSString *theCharacter = [tableList objectAtIndex:path.row];
    
    DVC.tempstring = [tableList objectAtIndex:path.row];
    
    //DVC.characterNumber = path.row;
    //DVC.characterName = theCharacter;
    
    
    
    
    
    
    
    
    
    
}

@end
