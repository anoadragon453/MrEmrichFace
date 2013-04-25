//
//  ViewController.m
//  Thank you
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan & Adrian McClure. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    AVAudioPlayer *player;
    BOOL finishedPlaying;
    BOOL flag;
}

@end

@implementation ViewController
@synthesize soundRecorder;
@synthesize SoundPath;
@synthesize chin;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //AVAudioRecorder Setup:
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir =[paths objectAtIndex:0];
    NSString *soundFilePath =[documentsDir stringByAppendingPathComponent:@"mysound.caf"];
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    self.SoundPath=newURL;
    recording = NO;
    flag = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facePressed:(id)sender {
    //Rate is most likely temporary... It's hardly pitch.

    [self initializeAVAudioPlayer:@"mysound" fileExtension:@".caf" Volume:1.0f Rate:1.5f];
    [player play];
    finishedPlaying = false;
    [self moveMouth:6];
}

-(void)moveMouth:(int)steps
{
    // check for end of loop
    if (steps == 0) return;
    
    // Enemy NE
    if(flag == true){
        [UIView animateWithDuration:.2
                         animations:^{ chin.center = CGPointMake(chin.center.x, chin.center.y + 30);}
                         completion:^(BOOL finished){flag = false;[self moveMouth:steps];}];
    }else{
        [UIView animateWithDuration:.2
                         animations:^{ chin.center = CGPointMake(chin.center.x, chin.center.y - 30);}
                         completion:^(BOOL finished){flag = true;if(finishedPlaying == false){[self moveMouth:steps];}}];
    }
    
    // Enemy NW
}

- (void)initializeAVAudioPlayer:(NSString*) name fileExtension:(NSString*)fileExtension Volume:(float) volume Rate:(float) rate {
    
    NSString* temp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* documentsPath = [temp stringByAppendingPathComponent:@"mysound.caf"];
    NSURL *url = [NSURL fileURLWithPath:documentsPath];
    
    NSError *error;
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [player setDelegate:(id)self];
    player.delegate = self;
    
    [player setVolume:volume];
    if(rate != 1.0f){
        player.enableRate = YES;
        player.rate = rate;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)data successfully:(BOOL)flag{
    NSLog(@"It finished playing!");
    finishedPlaying = true;
}

- (IBAction) recordOrStop: (id) sender {
    if (recording) {
        [soundRecorder stop];
        recording = NO;
        self.soundRecorder = nil;
        [recordOrStopButton setTitle: @"Record" forState:UIControlStateNormal];
        [recordOrStopButton setTitle: @"Record" forState:UIControlStateHighlighted];
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        NSDictionary *recordSettings =[[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                       [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
        AVAudioRecorder *newRecorder =[[AVAudioRecorder alloc] initWithURL: SoundPath
                                                                  settings: recordSettings error: nil];
        soundRecorder = newRecorder;
        soundRecorder.delegate = self;
        [soundRecorder prepareToRecord];
        [soundRecorder record];
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateNormal];
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateHighlighted];
        recording = YES;
    }
}

@end
