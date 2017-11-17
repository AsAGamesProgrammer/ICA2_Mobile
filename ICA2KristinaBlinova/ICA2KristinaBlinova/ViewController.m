//
//  ViewController.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 07/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>  //Camera
#import "VCResult.h"
//#import "VCResult.h"

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
-(void)stopReading;

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
        if([self startReading])
        {
            [_startBtn setTitle:@"Stop" forState:UIControlStateNormal];
            [_statusLbl setText:@"Scanning for code..."];
        }
    }
    else
    {
        //[self stopReading];
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    _isReading=!_isReading;
}

//Start Reading
-(BOOL) startReading
{
    NSError *error;

    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    //No input/error
    if(!input)
    {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    //-------CAPTURE DATA--------
    //Combining session with input
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    //Combining session with output
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispacthQueue;
    dispacthQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispacthQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //!!!!!!!!!!!!!!!!!!!!//
    //CHANGE QR CODE FOR WHATEVER//
    //!!!!!!!!!!!!!!!!!!!!//
    
    //----SHOW DATA TO THE USER------
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession]; //Initialization
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];             //Resizing
    [_videoPreviewLayer setFrame:_previewView.layer.bounds];                              //Setting bounds
    [_previewView.layer addSublayer:_videoPreviewLayer];                                  //Conecting video and layer
    

    //------RUN SESSION----
    [_captureSession startRunning];
    
    return YES;
}

-(void) stopReading
{
    [_captureSession stopRunning];
    _captureSession = nil;
    
    [_videoPreviewLayer removeFromSuperlayer];
}

//Capture output - function header provided by framework
-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(metadataObjects !=nil && [metadataObjects count] >0) //if any objects were captured
    {
        //Always interpret only the first captured object
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) //check if an oject read is a valid qr code
        {
            
            
            //Proccess QR code on the main thread
            //Status label with QR value
            [_statusLbl performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            //Video capture and display
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            //Button title
            [_startBtn performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start" waitUntilDone:NO];
            _isReading=NO;
            
            //NEXT SEGUE
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"resultSegue" sender:self];
            });

        }
    }
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

//SEGUE
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"resultSegue"])
    {
        VCResult *resultViewController = [segue destinationViewController];
        //resultViewController.strengthValue = @"5";
        
        //TODO: ADD A SUPER COOL ALGORITHM
        resultViewController.index = 2;
    }
}


@end
