//
//  ViewController.h
//  KWMusicPlayer
//
//  Created by Student P_03 on 04/11/16.
//  Copyright © 2016 kalyaniWarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    AVAudioPlayer *myAudioPlayer;
    BOOL isPlaying;
    MPMediaLibrary *nowPlaying;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playPauseAction:(id)sender;
- (IBAction)stopAction:(id)sender;



@end

