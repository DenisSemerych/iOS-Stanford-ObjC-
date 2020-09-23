//
//  Card.m
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@implementation Card

-(int)match: (NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score += 1;
        }
    }
    
    return score;
}
@end
