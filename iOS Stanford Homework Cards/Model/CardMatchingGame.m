//
//  CardMatchingGame.m
//  iOS Stanford Homework Cards
//
//  Created by Денис Семерич on 22.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS(int) int == 2 ? 6 : 4
#define MISMATCH_PENALTY(int) int == 2 ? 1 : 2
#define COST_TO_CHOSE  1

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *selectedCards;
@property (nonatomic) NSUInteger maxAllowedCardsToCompare;
@property (nonatomic, strong) NSMutableArray<GameMove *> *internalGameHistory;

-(int)matchCard:(Card *)card withSelected:(NSMutableArray *)cards;

@end

@implementation CardMatchingGame

- (NSArray<GameMove *> *)gameHistory
{
    return  [self.internalGameHistory copy];
}

- (NSMutableArray<GameMove *> *)internalGameHistory
{
    if (!_internalGameHistory) _internalGameHistory = [[NSMutableArray alloc] init];
    return _internalGameHistory;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)maxAllowedCardsToCompare
{
    if (!_maxAllowedCardsToCompare) _maxAllowedCardsToCompare = 2;
    return _maxAllowedCardsToCompare;
}

- (NSMutableArray *)selectedCards
{
    if (!_selectedCards) _selectedCards = [[NSMutableArray alloc] init];
    return _selectedCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)setMaxSelectedCardsCount:(NSUInteger)count
{
    self.maxAllowedCardsToCompare = count;
}

- (void)choseCardAtIndex:(NSUInteger)index
{
    Card *chonsenCard = [self.cards objectAtIndex:index];
    
    GameMove *move = [self.internalGameHistory lastObject];
    if (!(move.result == GAME_MOVE_PENDING)) {
        move = [[GameMove alloc] init];
        move.result = GAME_MOVE_PENDING;
        [self.internalGameHistory addObject:move];
    }
    
    [move.cardsInMove appendString:chonsenCard.contents];
    
    chonsenCard.chosen = !chonsenCard.isChosen;
    self.score -= COST_TO_CHOSE;
    
    if (self.selectedCards.count + 1 == self.maxAllowedCardsToCompare && chonsenCard.isChosen) {
        
        int matchResult = [self matchCard:chonsenCard withSelected:self.selectedCards];
        
        if (matchResult) {
            NSInteger moveScore = matchResult * MATCH_BONUS(self.maxAllowedCardsToCompare);
            self.score += moveScore;
            move.points = moveScore;
            move.result = GAME_MOVE_SUCCESS;
        } else {
            self.score -= MISMATCH_PENALTY(self.maxAllowedCardsToCompare);
            move.points = MISMATCH_PENALTY(self.maxAllowedCardsToCompare);
            move.result = GAME_MOVE_FAILED;
        }
            
        self.score = self.score;
        
        for (Card *card in self.cards) {
            if ([card isEqual:chonsenCard] && !card.isMatched) {
                card.chosen = YES;
                [self.selectedCards addObject:card];
            } else if (!card.isMatched) {
                card.chosen = NO;
            }
        }
    } else if (chonsenCard.isChosen && ![self.selectedCards containsObject:chonsenCard]) {
        [self.selectedCards addObject:chonsenCard];
    }
}

- (int)matchCard:(Card *)card withSelected:(NSMutableArray *)cards
{
    int result = [card match:cards];
    
    Card *nextToMatch = [cards lastObject];
    if (nextToMatch) {
        [cards removeLastObject];
        return result += [self matchCard:nextToMatch withSelected:cards];
    }
    
    return result;
}

@end
