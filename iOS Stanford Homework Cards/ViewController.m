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
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (weak, nonatomic) IBOutlet UILabel *gameMoveLabel;

- (void)setGameMoveInfoTextFromMove:(GameMove *) move;

- (NSString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end

@implementation ViewController


- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
        return _game;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.game setMaxSelectedCardsCount:2];
    } else {
        [self.game setMaxSelectedCardsCount:3];
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game choseCardAtIndex:cardIndex];
    [self updateUI];
    [self.gameModeControl setEnabled:false];
}

- (IBAction)resetGame:(UIButton *)sender {
    self.deck = nil;
    self.game = nil;
    
    [self.gameModeControl setEnabled:true];
    [self updateUI];
}

- (void)updateUI
{
    for (int i = 0; i < self.cardButtons.count; i++) {
        UIButton *button = [self.cardButtons objectAtIndex:i];
        Card *card = [self.game cardAtIndex:i];
        
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        button.enabled = !card.isMatched;
    }
    
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld", self.game.score]];
    GameMove *move = self.game.gameHistory.lastObject;
    if (move) {
        [self setGameMoveInfoTextFromMove:move];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"card_front" : @"card_back"];
}

- (void)setGameMoveInfoTextFromMove:(GameMove *)move
{
    NSString *text;
    if (move.result == GAME_MOVE_PENDING) {
        text = [NSString stringWithFormat: @"%@", move.cardsInMove];
    } else if (move.result == GAME_MOVE_FAILED) {
        text = [NSString stringWithFormat: @"%@ don’t match! %ld point penalty!",
                move.cardsInMove, (long)move.points];
    } else if (move.result == GAME_MOVE_SUCCESS) {
        text = [NSString stringWithFormat:@"Matched %@ for %ld points!",
                move.cardsInMove, move.points];
    }
    
    [self.gameMoveLabel setText:text];
}

@end
