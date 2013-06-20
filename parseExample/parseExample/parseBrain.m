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

    self->gameScore = [PFObject objectWithClassName:@"GameScore"];
    
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
    [query getObjectInBackgroundWithId:@"WBALBxPt8b" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        // NSLog(@"%@", gameScore);
    }];
}
- (void)deleteParseData{
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"V1wt3vAHFg" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
       // NSLog(@"%@", gameScore);
        [gameScore deleteInBackground];
    }];
   
}
- (void)getParseDataWithName:(NSString *)name{
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query whereKey:@"playerName" equalTo:name];
    //[query whereKey:@"cheatMode" equalTo:@"false"];
    [query whereKey:@"score" equalTo:[NSNumber numberWithInt:13]];
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

- (NSArray *)getData:(NSArray *)data{
    
    // Only use this code if you are already running it in a background
    // thread, or for testing purposes!
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"playerName = 'Dan Stemkosk'"];
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore" predicate:predicate];
    NSArray* scoreArray = [query findObjects];
    
    return scoreArray;
}
- (void)saveData:(NSArray *)data whichFieldName:(NSArray *)dataForKey{
    // gelen arraylerde int ve string ayrımı yapmak gerekiyor. Bu bir sorun array olarak almakta
    // sıkıntı Büyük ...

    [gameScore setObject:[NSNumber numberWithInt:[data[0] intValue]] forKey:dataForKey[0]];
    [gameScore setObject:data[1] forKey:dataForKey[1]];
    [gameScore setObject:[NSNumber numberWithBool:[data[2] boolValue]] forKey:dataForKey[2]];
    
    [gameScore saveInBackground];

    
 

}
- (void)updateData:(NSArray *)data where:(NSArray *)whereData{}
- (void)deleteData:(NSArray *)whereData{}

@end
