//
//  ParseViewController.h
//  parseExample
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface ParseViewController : UIViewController
                                <UITableViewDelegate, UITableViewDataSource,
                                PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
                                           

{

    IBOutlet UITextField * textField;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *postArray;
@property (weak, nonatomic) IBOutlet UIButton *logOutButtonTapAction;
@property IBOutlet UITextField * textField;




//- (void)getTodoDataWithName:(NSString *)name;
- (IBAction)addTodo:(UIButton *)sender;
- (IBAction)refleshButton:(UIButton *)sender;


@end
