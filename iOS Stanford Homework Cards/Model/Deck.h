//
//  Deck.h
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#ifndef Deck_h
#define Deck_h
#import "Card.h"
#import <Foundation/Foundation.h>

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end


#endif /* Deck_h */
