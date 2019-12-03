//
//  JDCCardController.m
//  DeckOfOneCardOBJ-C
//
//  Created by jdcorn on 12/3/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

#import "JDCCardController.h"
#import "JDCCard.h"

static NSString *const baseURLString = @"https://deckofcardsapi.com/api/deck/new/";

@implementation JDCCardController

+ (void)drawNewCard:(NSNumber *)numberOfCards completion:(void (^)(NSArray<JDCCard *> *_Nullable))completion
{
    /// turning the string URL into baseURL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    /// appending "draw/" to the end of the baseURL
    NSURL *drawURL = [baseURL URLByAppendingPathComponent:@"draw/"];
    
    /// converting cardCount to a string since it's an Int
    NSString *cardCount = [numberOfCards stringValue];
    
    /// adding our query items to our defined nsurlcomponents
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    
    /// telling the api how many cards we want
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    
    /// add query items to NSURLComponents
    urlComponents.queryItems = @[queryItem];
    
    /// the final URL
    NSURL *searchURL = urlComponents.URL;
    
    /// define dataTask
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        /// handle error first
        if (error)
        {
            NSLog(@"There was an error:: %@, %@", error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        /// handle data
        if (!data)
        {
            NSLog(@"Error");
            completion(nil);
            return;
        }
        
        /// decode json data from api
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: 2 error: &error];
        
        /// making sure jsonDictionary isn't nil, otherwise return
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error creating dictionary from json");
            completion(nil);
            return;
        }
        
        /// access array value at the key "cards"
        NSArray *cardsArray = jsonDictionary[@"cards"];
        
        /// mutablearray is necessary so we can append objects, regular arrays can't be edited
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        /// with our mutable array we can loop through cardsArray and bring in cards from each dictionary in the array and add them to the mutable array
        for (NSDictionary *cardDictionary in cardsArray)
        {
            /// init card object from cardDictionary and append to mutable array
            JDCCard *card = [[JDCCard alloc] initWithDictionary: cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        
        /// after looping through the array with the objects we want we can complete
        completion(cardsPlaceholder);
        
    }] resume];
}

+ (void)fetchCardImage:(JDCCard *)card completion:(void (^)(UIImage * _Nonnull))completion
{
    
    /// converting our imageString to an NSURL
    NSURL *imageURL = [NSURL URLWithString:card.imageURL];
    
    /// define dataTask
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /// handle error first
        if(error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        /// make sure we have data, if not print error and complete
        if (!data)
        {
            NSLog(@"Error: no data returned");
            completion(nil);
            return;
        }
        
        /// with the data, initialize an image using that data
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
        
    }]resume];
}

@end
