//
//  JDCCardController.h
//  DeckOfOneCardOBJ-C
//
//  Created by jdcorn on 12/3/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JDCCard;

NS_ASSUME_NONNULL_BEGIN

@interface JDCCardController : NSObject

+ (void)drawNewCard:(NSNumber *)numberOfCards completion:(void(^) (NSArray<JDCCard *> *_Nullable cards))completion;

+ (void)fetchCardImage:(JDCCard *)card completion:(void(^) (UIImage *_Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
