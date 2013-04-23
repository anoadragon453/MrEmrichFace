//
//  SecondRecordViewController.m
//  Record
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import "SecondRecordViewController.h"

@interface SecondRecordViewController (){
    AVAudioPlayer *player;
}
@end

@implementation SecondRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeAVAudioPlayer:player fileExtension:@".mp3" Volume:1.0f];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordPressed:(id)sender {
}

- (IBAction)playPressed:(id)sender {
}

- (IBAction)stopPressed:(id)sender {
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
