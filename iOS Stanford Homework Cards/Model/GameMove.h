//
//  GameHistory.h
//  iOS Stanford Homework Cards
//
//  Created by Денис Семерич on 15.10.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#ifndef GameHistory_h
#define GameHistory_h

#define GAME_MOVE_PENDING 3
#define GAME_MOVE_SUCCESS 1
#define GAME_MOVE_FAILED 0

#import <Foundation/Foundation.h>

@interface GameMove : NSObject

@property (nonatomic, readwrite) NSMutableString *cardsInMove;
@property (nonatomic, readwrite) NSInteger result;
@property (nonatomic, readwrite) NSInteger points;

@end

#endif /* GameHistory_h */
