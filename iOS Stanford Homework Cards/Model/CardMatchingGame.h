//
//  CardMatchingGame.h
//  iOS Stanford Homework Cards
//
//  Created by Денис Семерич on 22.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#ifndef CardMatchingGame_h
#define CardMatchingGame_h

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "GameMove.h"

@interface CardMatchingGame : NSObject

// disignated
- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;
- (void)setMaxSelectedCardsCount:(NSUInteger) count;
- (void)choseCardAtIndex: (NSUInteger) index;
- (Card *)cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSArray<GameMove *> *gameHistory;

@end


#endif /* CardMatchingGame_h */
