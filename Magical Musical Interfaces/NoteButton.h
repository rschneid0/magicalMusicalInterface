//
//  NoteButton.h
//  Magical Musical Interfaces
//
//  Created by Rolando Schneiderman on 6/1/15.
//  Copyright (c) 2015 pindro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardProtocol
- (IBAction)startPlayNote:(id)sender;
- (IBAction)stopPlayNote:(id)sender;
@end

@interface NoteButton : UIButton{
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@property (weak) id <KeyboardProtocol>delegate;
@property UInt32 pitch;
@end
