//
//  PlayingCard.h
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#ifndef PlayingCard_h
#define PlayingCard_h
#import "Card.h"

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end

#endif /* PlayingCard_h */
