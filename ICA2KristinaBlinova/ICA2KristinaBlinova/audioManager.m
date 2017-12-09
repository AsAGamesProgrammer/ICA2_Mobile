//
//  audioManager.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "audioManager.h"
#import <AVFoundation/AVFoundation.h>

//Audio Players
 AVAudioPlayer *audioWeaponPlace;
 AVAudioPlayer *audioHeroPlace;

@implementation audioManager

-(void) initializePlayer
{
    //PLACE WEAPON
    audioWeaponPlace = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/metalicSound.mp3"] error:nil];
    audioHeroPlace = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/placeHero.mp3"] error:nil];
}

-(NSURL*)createSoundURL:(NSString*)soundPath
{
    NSString *path = [NSString stringWithFormat:soundPath, [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    return soundUrl;
}

-(void) playPlaceWeaponAudio
{
    [audioWeaponPlace play];
}

-(void) playPlaceHeroAudio
{
    [audioHeroPlace play];
}

@end
