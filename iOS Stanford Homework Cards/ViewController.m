//
//  ViewController.m
//  iOS Stanford Homework Cards
//
//  Created by Denys Semerych on 15.09.2020.
//  Copyright © 2020 Denys Semerych. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlaingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (nonatomic, strong) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) UInt64 flipCount;
@end

@implementation ViewController

@synthesize flipCount = _flipCount;

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}


- (UInt64) flipCount {
    if (!_flipCount) _flipCount = 0;
    return _flipCount;
}

- (void) setFlipCount:(UInt64)flipCount {
    _flipCount = flipCount;
    [_flipCountLabel setText: [NSString stringWithFormat:@"Flip`s count %llu", flipCount]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flipCount = 0;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"card_back"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:@"card_front"] forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            self.flipCount++;
        } else {
            [self dropCardViewFromTable];
        }
    }
}

- (void)dropCardViewFromTable {
    [UIView animateWithDuration:0.1f animations:^{
        self.cardButton.frame = CGRectMake(0, 0, 0, 0);
    }];
}

@end
