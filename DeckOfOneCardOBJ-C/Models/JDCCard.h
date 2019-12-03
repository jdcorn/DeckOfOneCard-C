//
//  JDCCard.h
//  DeckOfOneCardOBJ-C
//
//  Created by jdcorn on 12/3/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCCard : NSObject

@property (nonatomic) NSString *suit;
@property (nonatomic) NSString *imageURL;

/// similar to a protocol, the header file just declares what methods will be in the implementation file, if it's here, it has to be there.
- (instancetype)initWithSuit:(NSString *)suit
                    imageURL:(NSString *)imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
