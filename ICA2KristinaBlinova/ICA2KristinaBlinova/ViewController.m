//
//  ViewController.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 07/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>  //Camera

@interface ViewController () <AVCaptureMetadataOutputObjectsDelegate>

//Connections to UI
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

//Button action
- (IBAction)startStopScan:(id)sender;

//Flags
@property (nonatomic) BOOL isReading;

//Private functions
-(BOOL)startReading;

//AV properties
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ViewController

//IMPLEMENTATION
- (IBAction)startStopScan:(id)sender
{
    if(!_isReading)
    {
        //if([self startReading])
        //{
            [_startBtn setTitle:@"Stop" forState:UIControlStateNormal];
            [_statusLbl setText:@"Scanning for code..."];
        //}
    }
    else
    {
        //[self stopReading];
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    _isReading=!_isReading;
}


//INITIAL SET UP
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initially set flag to false
    _isReading=NO;
    
    _captureSession = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
