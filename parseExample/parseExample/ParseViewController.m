//
//  ParseViewController.m
//  parseExample
//
//  Created by arif kaplan on 17.06.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "ParseViewController.h"

@interface ParseViewController ()

@end

@implementation ParseViewController
@synthesize textField;
@synthesize dataArray, dataForKey;


- (parseBrain *)Brain{
    
    if(!Brain){
        Brain = [[parseBrain alloc] init];
    }
    return Brain;
}


-(IBAction)saveButton:(UIButton *)sender{
    [self Brain];
    
    // clouda yüklencek veri seti oluşturulur.
    dataArray = [NSArray arrayWithObjects: @"13", @"deneme", @"YES", nil];
    // veri seti ile uyumlu alan isimleri oluşturulur.
    dataForKey = [NSArray arrayWithObjects: @"score", @"playerName", @"cheatMode", nil];
    
    [Brain saveData:dataArray whichFieldName:dataForKey];
    
    
}

- (IBAction)getButton:(UIButton *)sender{
    [self Brain];
    [Brain getParseData];
    
}

- (IBAction)deleteButton:(UIButton *)sender{
    [self Brain];
    [Brain deleteParseData];
    
}
- (void)comeButton:(UIButton *)sender{
    [self Brain];
    
    [Brain getParseDataWithName:textField.text];
    
    
}


@end

