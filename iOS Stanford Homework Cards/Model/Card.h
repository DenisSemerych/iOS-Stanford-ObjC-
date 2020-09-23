//
//  Card.h
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#ifndef Card_h
#define Card_h
#import <Foundation/Foundation.h>

@interface Card: NSObject
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match: (NSArray *)otherCards;

@end

#endif /* Card_h */
