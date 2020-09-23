//
//  CardMatchingGame.m
//  iOS Stanford Homework Cards
//
//  Created by Денис Семерич on 22.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *selectedCards;

-(int)matchCard:(Card *)card withSelected:(NSMutableArray *)cards;

@end

@implementation CardMatchingGame

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOSE = 1;
static const int MAX_ALLOWED_CARDS_TO_COMPARE = 3;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
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

- (void)choseCardAtIndex:(NSUInteger)index
{
    Card *chonsenCard = [self.cards objectAtIndex:index];
    chonsenCard.chosen = !chonsenCard.isChosen;
    self.score -= COST_TO_CHOSE;
    
    if (self.selectedCards.count + 1 == MAX_ALLOWED_CARDS_TO_COMPARE && chonsenCard.isChosen) {
        
        int matchResult = [self matchCard:chonsenCard withSelected:self.selectedCards];
        
        if (matchResult) {
            self.score += matchResult * MATCH_BONUS;
        } else {
            self.score -= MISMATCH_PENALTY;
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
