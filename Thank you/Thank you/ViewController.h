//
//  ViewController.h
//  Thank you
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVPlayer.h>

@interface ViewController : UIViewController
<AVAudioPlayerDelegate>
- (IBAction)facePressed:(id)sender;

@end
