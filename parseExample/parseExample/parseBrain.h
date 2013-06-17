//
//  parseBrain.h
//  Quiz
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface parseBrain : NSObject
{
    PFObject *gameScore;

}
- (id)init;
- (void)parseSave;
- (void)getParseData;
- (void)deleteParseData;
- (void)getParseDataWithName:(NSString*)name;
@end
