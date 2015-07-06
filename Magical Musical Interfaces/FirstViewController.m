//
//  SCSynthMixerViewController.m
//  SynthMixDemo
//
//  Created by Stephen Cussen on 12/5/13.
//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import "FirstViewController.h"
#import "SCAudioController.h"

// some MIDI constants:
enum {
    kMIDIMessage_NoteOn    = 0x9,
    kMIDIMessage_NoteOff   = 0x8,
};

enum{lowNote, midNote, highNote};

// define some midi notes to play - middle C (60), C one octave below (48) and C one octave above (72)
#define kLowNote  60
#define kMidNote  61
#define kHighNote 62

@interface FirstViewController ()
@property SCAudioController *ssAudio;
@end

@implementation FirstViewController
@synthesize ssAudio;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // work around for the annoying segmented control tint bug
    
    //    [self.mySegmentedControl setTintColor:[UIColor clearColor]];
    //    [self.mySegmentedControl setTintColor:self.view.tintColor];
    
    
    // setup the Sound Scape Audio Control
    ssAudio = [[SCAudioController alloc] init];
    [ssAudio setupAudio];
    self.view.multipleTouchEnabled=YES;
    ssAudio.bus1IsOn =NO;
    _bus1Button.selected = YES;
    ssAudio.bus2IsOn = YES;
    _bus2Button.selected = NO;
    
    _bus1PresetName.text = @"Fantasia 2";
    _bus2PresetName.text = @"Fiddle";
    //[[UINavigationBar appearance]  setTintColor:[UIColor clearColor]];
    //[[UINavigationBar appearance]  setTintColor:[UIColor greenColor]];
    
    NoteButton* one = [[NoteButton alloc] init];
    [one setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    one.tag=60;
    one.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [one setFrame:CGRectMake(10, 250, 100, 100)];
    [self.view addSubview:one];

    
    NoteButton* two = [[NoteButton alloc] init];
    [two setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    two.tag=63;
    two.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [two setFrame:CGRectMake(115, 250, 100, 100)];
    [self.view addSubview:two];

    
    NoteButton* three = [[NoteButton alloc] init];
    [three setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    three.tag=65;
    three.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [three setFrame:CGRectMake(220, 250, 100, 100)];
    [self.view addSubview:three];
    
    NoteButton* four = [[NoteButton alloc] init];
    [four setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    four.tag=66;
    four.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [four setFrame:CGRectMake(10, 360, 100, 100)];
    [self.view addSubview:four];
    
    
    NoteButton* five = [[NoteButton alloc] init];
    [five setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    five.tag=67;
    five.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [five setFrame:CGRectMake(115, 360, 100, 100)];
    [self.view addSubview:five];
    
    
    NoteButton* six = [[NoteButton alloc] init];
    [six setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    six.tag=70;
    six.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [six setFrame:CGRectMake(220, 360, 100, 100)];
    [self.view addSubview:six];

    
    NoteButton* seven = [[NoteButton alloc] init];
    [seven setImage:[UIImage imageNamed:@"flower1.png"] forState:UIControlStateNormal];
    seven.tag=72;
    seven.delegate=self;
    //[one addTarget:self action:@selector(startPlayNote:) forControlEvents:UIControlEventTouchDown];
    //[one addTarget:self action:@selector(stopPlayNote:) forControlEvents:UIControlEventTouchCancel];
    [seven setFrame:CGRectMake(175, 80, 100, 100)];
    [self.view addSubview:seven];


    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Audio control

// Start the note play
- (IBAction) startPlayNote:(id)sender {
    UIButton *button = (UIButton*) sender;
    UInt32 noteNum;
    
    switch(button.tag) {
        case lowNote:
            noteNum = kLowNote;
            break;
        case midNote:
            noteNum = kMidNote;
            break;
        case highNote:
            noteNum = kHighNote;
            break;
        default:
            noteNum = kMidNote;
            break;
    }
    noteNum=(UInt32)button.tag;
    UInt32 onVelocity = 127;
    UInt32 noteCommand = 	kMIDIMessage_NoteOn << 4 | 0;
    OSStatus result = noErr;
    if(ssAudio.bus1IsOn) result = MusicDeviceMIDIEvent(ssAudio.samplerUnit, noteCommand, noteNum, onVelocity, 0);
    if (result != noErr) NSLog (@"Unable to start playing the note on samplerUnit. Error code: %d\n", (int) result);
    if(ssAudio.bus2IsOn) result = MusicDeviceMIDIEvent(ssAudio.samplerUnit2, noteCommand, noteNum, onVelocity, 0);
    if (result != noErr) NSLog (@"Unable to start playing the note on samplerUnit2. Error code: %d\n", (int) result);
}



// Stop the note play
- (IBAction) stopPlayNote:(id)sender {
    UIButton *button = (UIButton*) sender;
    UInt32 noteNum;
    
    switch(button.tag) {
        case lowNote:
            noteNum = kLowNote;
            break;
        case midNote:
            noteNum = kMidNote;
            break;
        case highNote:
            noteNum = kHighNote;
            break;
        default:
            noteNum = kMidNote;
            break;
    }
    noteNum=(UInt32)button.tag;
    UInt32 noteCommand = 	kMIDIMessage_NoteOff << 4 | 0;
    OSStatus result = noErr;
    if(ssAudio.bus1IsOn) result = MusicDeviceMIDIEvent(ssAudio.samplerUnit, noteCommand, noteNum, 0, 0);
    if (result != noErr) NSLog (@"Unable to stop playing the note on samplerUnit. Error code: %d\n", (int) result);
    if(ssAudio.bus2IsOn) result = MusicDeviceMIDIEvent(ssAudio.samplerUnit2, noteCommand, noteNum, 0, 0);
    if (result != noErr) NSLog (@"Unable to stop playing the note on samplerUnit2. Error code: %d\n", (int) result);
}

- (IBAction)pitchAdjustmentChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int pitchAdj = (int)roundf(slider.value);
    if (abs(pitchAdj) <= 5 ) {
        pitchAdj = 0;
    }
    NSLog(@"Pitch adjustment value = %d", pitchAdj);
    _pitchAdjustmentValue.text = [NSString stringWithFormat:@"%d", pitchAdj];
    int result = [ssAudio pitchAdj:pitchAdj];
    
    if(result != 0) NSLog (@"Unable to set the property pitch adjustment parameter on the effects unit. Error code: %d\n", (int) result);
}

- (IBAction)toggleBus1:(id)sender {
    ssAudio.bus1IsOn = !ssAudio.bus1IsOn;
    if (ssAudio.bus1IsOn) _bus1Button.selected = YES;
    else _bus1Button.selected = NO;
}

- (IBAction)toggleBus2:(id)sender {
    ssAudio.bus2IsOn = !ssAudio.bus2IsOn;
    if (ssAudio.bus2IsOn) _bus2Button.selected = YES;
    else _bus2Button.selected = NO;
}


@end
