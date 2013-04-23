//
//  ViewController.m
//  Thank you
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
     AVAudioPlayer *player;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This is when you would call the mouth up and down movements
- (IBAction)facePressed:(id)sender {
    [self initializeAVAudioPlayer:@"heykids" fileExtension:@".mp3" Volume:1.0f];
    [player play];
}

// Something like this
- (void)mouthMove{
    // Make the mouth move up and down. Doesn't have to match the voice...
}

- (void)mouthStop{
    // Make the Mouth return to the original position, ok if its not animated.
}

// Also need to initialize an AVAudioPlayer, like so:
// AVAudioPlayer *player;

// After initialization, the [player play] needs to run, where player is the AVAudioPlayer variable.

// You also need to make your interface in .h look like: @interface GirlAndBunnyViewController : UIViewController<AVAudioPlayerDelegate>

// Call initializeAVAudioPlayer with something similar to:


- (void)initializeAVAudioPlayer:(NSString*) name fileExtension:(NSString*)fileExtension Volume:(float) volume {
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:name ofType:fileExtension];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    
    NSError *error;
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [player setDelegate:(id)self];
    player.delegate = self;
    
    [player setVolume:volume];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)data successfully:(BOOL)flag{
    NSLog(@"It finished playing!");
}





@end
