//
//  ParseViewController.h
//  parseExample
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "parseBrain.h"

@interface ParseViewController : UIViewController

{
    parseBrain * Brain;
    IBOutlet UITextField * textField;
}
@property IBOutlet UITextField * textField;
@property NSArray *dataArray;
@property NSArray *dataForKey;
- (parseBrain *)Brain;
- (IBAction)saveButton:(UIButton *)sender;
- (IBAction)getButton:(UIButton *)sender;
- (IBAction)deleteButton:(UIButton *)sender;
- (IBAction)comeButton:(UIButton *)sender;

@end
