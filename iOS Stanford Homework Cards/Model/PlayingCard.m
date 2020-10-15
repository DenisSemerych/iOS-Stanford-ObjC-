//
//  PlayingCard.m
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♠", @"♥", @"♣", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(int)match: (NSArray *)otherCards {
    
    int score = 0;
    
    for (id obj in otherCards) {
        if ([obj isKindOfClass: [PlayingCard class]]) {
            PlayingCard *card = (PlayingCard *)obj;
            if ([self.suit isEqualToString:card.suit]) {
                self.matched = YES;
                card.matched = YES;
                score += 1;
            }
            if (self.rank == card.rank) {
                self.matched = YES;
                card.matched = YES;
                score += 4;
            }
        }
    }
    
    return score;
}
@end
