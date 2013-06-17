//
//  parseBrain.m
//  Quiz
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "parseBrain.h"

@implementation parseBrain

- (id)init{

    gameScore = [PFObject objectWithClassName:@"GameScore"];
    
    return self;
}
- (void)parseSave{
    
    
    [gameScore setObject:[NSNumber numberWithInt:135] forKey:@"score"];
    [gameScore setObject:@"asd Kaplan" forKey:@"playerName"];
    [gameScore setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
    
    //saveInBackground komutu anında apiye yüklem yapılabilinir.
    //saveEventually komutu offline kayıt alır.
    
    [gameScore saveInBackground];
}
- (void)getParseData{
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"udZC5x39st" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", gameScore);
    }];
}

- (void)deleteParseData{
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"J07gF2UN4b" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
       // NSLog(@"%@", gameScore);
        [gameScore deleteInBackground];
    }];
}

- (void)getParseDataWithName:(NSString *)name{
    
    NSLog(@"%@",name);
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query whereKey:@"playerName" equalTo:name];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
