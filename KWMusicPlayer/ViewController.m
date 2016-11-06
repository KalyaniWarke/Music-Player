//
//  ViewController.m
//  KWMusicPlayer
//
//  Created by Student P_03 on 04/11/16.
//  Copyright © 2016 kalyaniWarke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isPlaying = false;
    
    self.durationSlider.userInteractionEnabled = NO;
    
    self.durationSlider.minimumValue = 0;
    self.durationSlider.value = 0;
    
    [self.durationSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDurationSlider) userInfo:nil repeats:YES];
    
}
-(void)updateDurationSlider {
    
    if (self.durationSlider.value == myAudioPlayer.duration) {
        timer = nil;
    }
    self.durationSlider.value = myAudioPlayer.currentTime;
}

-(BOOL)initialzeAudioplayer{
    BOOL status =false;
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    if (musicURL !=nil) {
        NSError *error;
        myAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error!=nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            [self getArtWorkWithFileUrl:musicURL];
            
            self.durationSlider.maximumValue = myAudioPlayer.duration;
            status = true;
        }
        
    }
       return status;
}

-(void)getArtWorkWithFileUrl:(NSURL *)fileURL{
    AVAsset *asset =[AVURLAsset URLAssetWithURL:fileURL options:nil];
   
   
   //
//
//    NSArray *artists =[AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
//    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
//    AVMetadataItem *title =[titles objectAtIndex:0];
//    AVMetadataItem *artist = [artists objectAtIndex:0];
//    AVMetadataItem *albumName =[albumNames objectAtIndex:0];
    
    NSArray *key= [NSArray arrayWithObjects:@"commonMetaData", nil];
    [asset loadValuesAsynchronouslyForKeys:key completionHandler:^{
         NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
        for (AVMetadataItem *item in titles){
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceCommon]) {
                
               // NSData *data =[item.value copyWithZone:nil];
                MPMediaItem *song =[[MPMusicPlayerController systemMusicPlayer]nowPlayingItem];
                _titleLabel= [song valueForProperty:MPMediaItemPropertyTitle];
               
            }
            else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]){
                            }
            
        }

        
        NSArray *artWorks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
        for (AVMetadataItem *item in artWorks){
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                
                NSData *data =[item.value copyWithZone:nil];
                UIImage *image = [UIImage imageWithData:data];
                self.imageView.image=image;
            }
            else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]){
                self.imageView.image=[UIImage imageWithData:[item.value copyWithZone:nil]];
            }
        }
    }];

}

- (IBAction)playPauseAction:(id)sender {
    UIButton *button = sender;
    if ([button.currentImage isEqual:[UIImage imageNamed:@"play.jpeg"]]) {
        if(isPlaying ){
            
            [myAudioPlayer play];
            [self startTimer];
 
        }
        else {
            if ([self initialzeAudioplayer]) {
                [myAudioPlayer play];
                [self startTimer];

                isPlaying=true;
            }
            else{
                NSLog(@"something wents to wrong while initialzing audio player");

                }
            }
        [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        }
    else if ([button.currentImage isEqual:[UIImage imageNamed:@"pause.jpeg"]]){
        
        [myAudioPlayer pause];
        [timer invalidate];

        [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)stopAction:(id)sender {
    
    [myAudioPlayer stop];
    isPlaying = false;
    self.durationSlider.value = 0;
    [timer invalidate];
    timer = nil;

    [self.playButton setTitle:@"play" forState:UIControlStateNormal];
}

//-(NSString *)getSongTitle{
//    MPMediaItem *song =[[MPMusicPlayerController systemMusicPlayer]nowPlayingItem];
//    _titleLabel= [song valueForProperty:MPMediaItemPropertyTitle];
//
//    return _titleLabel;
//}
@end
