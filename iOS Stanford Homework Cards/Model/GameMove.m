//
//  GameMove.m
//  iOS Stanford Homework Cards
//
//  Created by Денис Семерич on 15.10.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import "GameMove.h"

@implementation GameMove

- (NSMutableString *)cardsInMove
{
    if (!_cardsInMove) _cardsInMove = [[NSMutableString alloc] init];
    return _cardsInMove;
}


@end
