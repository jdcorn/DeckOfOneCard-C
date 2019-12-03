//
//  JDCCard.m
//  DeckOfOneCardOBJ-C
//
//  Created by jdcorn on 12/3/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

#import "JDCCard.h"

@implementation JDCCard

- (instancetype)initWithSuit:(NSString *)suit imageURL:(NSString *)imageURL
{
    if (self = [super init]) {
        
        _suit = suit;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{

    NSString *suit = dictionary[@"suit"];
    NSString *imageURL = dictionary[@"image"];
    
    return [self initWithSuit:suit imageURL:imageURL];
}

@end
