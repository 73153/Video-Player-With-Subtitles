//
//  MainViewController.m
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "MainViewController.h"
#import "AddViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "Password.h"
#import "RecordCell.h"
#import "Constants.h"
#import "ResetPasswordViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize aPasswords;
@synthesize managedObjectContext;

- (instancetype)initWithStyle:(UITableViewStyle)style
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

    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    // sorting
    NSSortDescriptor *sortDesc1 = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[sortDesc1];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Fetching item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Sigh..."
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [self setAPasswords:mutableFetchResults];
    
    if (self.aPasswords.count > 0) {
        for (int i=0; i < self.aPasswords.count; i++) {
            if ([[(Password *)(self.aPasswords)[i] title] isEqualToString: strAppUnlockTitle] && [[(Password *)(self.aPasswords)[i] username] isEqualToString: strAppUnlockName]) {
                // NCA password. Hidden
                [self.aPasswords removeObjectAtIndex:i];
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!self.aPasswords) {
        self.aPasswords = [[NSMutableArray alloc] init];
    }
    [self.aPasswords insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aPasswords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecordCell";
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Password *item = (Password *)aPasswords[indexPath.row];
    cell.titleLabel.text = [item title];
    cell.notesLabel.text = [item notes];
    NSLog(@"%@, %@, %@, %@, %@", item.title, item.username, item.password, item.website, item.notes);     //debug
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        DetailViewController *dvc = [segue destinationViewController];
        dvc.record = (Password *)(self.aPasswords)[[self.tableView indexPathForSelectedRow].row];

        // record this visit
        [(Password *)dvc.record setVisitctr:@([[(Password *)dvc.record visitctr] intValue] + 1)];
        [(Password *)dvc.record setVisitdt: [NSDate date]];
        dvc.delegate = self;
    }
}

#pragma mark - Unwind segues
- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"DoneAdding"]) {        
        AddViewController *addController = [segue sourceViewController];
        [self addRecord:addController.titleIn.text name:addController.userIn.text password:addController.passwordIn.text onWeb:addController.websiteIn.text withNotes:addController.notesIn.text];
        [[self tableView] reloadData];
    }
    else if ([[segue identifier] isEqualToString:@"ChangePassword"]) {
        Password *pswd;
        // Search to see if login password is set
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
            [request setEntity:entity];
            
            //add predicates
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@ AND username = %@", strAppUnlockTitle, strAppUnlockName];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
            if (mutableFetchResults == nil) {
                // Handle the error.
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                message:@"Fetching item failed."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Sigh..."
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            pswd = (Password *)mutableFetchResults[0];
        }

        ResetPasswordViewController *rpvc = [segue sourceViewController];
        pswd.password = rpvc.passwordIn.text;
        [self UpdateRecord:pswd];
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - LockViewController delegate
- (BOOL) verify: (NSString *)code
{
    // Search to see if login password is set
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    //add predicates
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@ AND username = %@", strAppUnlockTitle, strAppUnlockName];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Fetching item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Sigh..."
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    Password * pswd = (Password *)mutableFetchResults[0];
    if ([code isEqualToString: pswd.password]) {
        return YES;
    }
    return NO;
}

#pragma mark - LoginViewController delegate
- (void)addRecord:(NSString *)title name:(NSString *)username password:(NSString *)pswd onWeb:(NSString *)website withNotes:(NSString *)notes
{
    NSLog(@"Adding new item: title=%@, username=%@, password=%@, website=%@, notes=%@", title, username, pswd, website, notes);
    
    if (self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
	// Create and configure a new instance of the Event entity.
	Password *item = (Password *)[NSEntityDescription insertNewObjectForEntityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    
	[item setTitle: title];
	[item setUsername: username];
	[item setPassword: pswd];
    [item setWebsite:website];
    [item setNotes:notes];
    [item setVisitctr:@0];
    [item setVisitdt:[NSDate date]];
    
	if (![self saveContext]) {
    	// Handle the error.
		UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Saving item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
		[alert show];
	}
    
    // Add item to current view
    if (!self.aPasswords) {     //todo - more thoughts
        self.aPasswords = [[NSMutableArray alloc] init];
    }
    [self.aPasswords insertObject:item atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - DetialViewController delegate
- (void)UpdateRecord:(Password*) item
{
    NSLog(@"Updating %@", item.title);
    if (![self saveContext]) {
    	// Handle the error.
		UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Updating item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
		[alert show];
	}
    
    [self.tableView reloadData];
}

- (BOOL) saveContext
{
    NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error saving: %@", error.localizedDescription);
    	return NO;
	}
    
    return YES;
}

#pragma mark - EditViewController delgate
-(void) deletePassword:(Password *) item
{
    [self.aPasswords removeObject:item];
    [self.managedObjectContext deleteObject:item];
    if (![self saveContext]) {
    	// Handle the error.
		UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Updating item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
		[alert show];
	}
    [self.tableView reloadData];
}

@end
