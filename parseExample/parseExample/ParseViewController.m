//
//  ParseViewController.m
//  parseExample
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "ParseViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"

@interface ParseViewController ()

@end

@implementation ParseViewController


@synthesize postArray;
@synthesize tableView;
@synthesize textField;
-(void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    [self.tableView  reloadData];
  

}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        NSLog(@"giriş başarılı");
    } else {
        NSLog(@"giremedi");
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Check if user is logged in
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = @[@"friends_about_me"];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
        
        // Customize the Sign Up View Controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
        logInViewController.signUpController = signUpViewController;
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }else {
        [self getTodoDataWithName:[[PFUser currentUser] username] ];
    
    }
}


#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}



// çıkış işlemi için aşagıdaki metod kullanılıyor.
- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
     postArray = nil;
    [self.tableView reloadData];
    [self viewDidAppear:YES];
    
}


// uygulamaya giriş yaptıktan sonra gerekli olan metodlar aşagıda tanımlanmıştır.



//todo eklemek için kullanılan metot.
// text field a girilen todo yu parsa kaydetmek için kullanılır.
-(IBAction)addTodo:(UIButton *)sender{

    
    NSString *content = [textField text];
    
    if ( content.length != 0 ){
        [textField setText:@""];
        [self.textField endEditing:YES];
        NSString *name = [[PFUser currentUser] username];
          
    
        PFObject *todo = [PFObject objectWithClassName:@"Todo"];
    
        [todo setObject:content forKey:@"content"];
        [todo setObject:name forKey:@"userName"];
    
        //saveInBackground komutu anında apiye yüklem yapılabilinir.
        //saveEventually komutu offline kayıt alır.
    
        [todo saveInBackground];
    }
    
    [self getTodoDataWithName:[[PFUser currentUser] username] ];

}
- (IBAction)refleshButton:(id)sender{
    
   
    //Create query for all Post object by the current user
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Todo"];
    [postQuery whereKey:@"userName" equalTo:[[PFUser currentUser] username]];
    [postQuery orderByDescending:@"createdAt"];
    // Run the query
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //Save results and update the table
            postArray = objects;
            [self.tableView  reloadData];
        }
    }];
    
  

}


- (void)getTodoDataWithName:(NSString *)name{
   
    // Then, elsewhere in your code...
    PFQuery *query = [PFQuery queryWithClassName:@"Todo"];
    [query whereKey:@"userName" equalTo:name];
    
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithTarget:self
                                    selector:@selector(findCallback:error:)];
    
    
}
- (void)findCallback:(NSArray *)results error:(NSError *)error {
    
    if (!error) {
        // Do somethin0 g with the found objects
        postArray = results;
        [self.tableView  reloadData];
    }else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
    
    
    
}
- (void)getCallback:(PFObject *)deleteTodo error:(NSError *)error {
    if (!error) {
        [deleteTodo deleteInBackground];
         [self getTodoDataWithName:[[PFUser currentUser] username]];
    } else {
        // Log details of our failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dateString;
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
        
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell with the textContent of the Post as the cell's text label
    PFObject *post = [postArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[post objectForKey:@"content"]];
    dateString = [formatter stringFromDate:[post createdAt]];

    [cell.detailTextLabel setText: dateString];
 
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *deleteId = [[postArray objectAtIndex:indexPath.row] objectId];
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Todo"];
        [query getObjectInBackgroundWithId:deleteId
                                    target:self
                                  selector:@selector(getCallback:error:)];

    }
}









@end

