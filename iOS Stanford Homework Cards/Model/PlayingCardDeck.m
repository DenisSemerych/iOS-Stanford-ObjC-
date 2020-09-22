//
//  PlayingCardDeck.m
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank ++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard: card];
            }
        }
    }
    
    return self;
}

@end
