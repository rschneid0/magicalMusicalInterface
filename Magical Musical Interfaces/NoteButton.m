//
//  NoteButton.m
//  Magical Musical Interfaces
//
//  Created by Rolando Schneiderman on 6/1/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import "NoteButton.h"

@implementation NoteButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.delegate stopPlayNote:self];
    NSLog(@"Touches Ended");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.delegate startPlayNote:self];
    NSLog(@"Touches Began");
}


@end
