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

//Passed values
@property (nonatomic) int nextIndex;
@property (nonatomic) RecordTypes codeType;
@property (nonatomic) NSString* codeName;

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
    
    //CODE TYES
    dispatch_queue_t dispacthQueue;
    dispacthQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispacthQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects: AVMetadataObjectTypeQRCode,     //qr
                                                                             AVMetadataObjectTypeAztecCode,  //aztec
                                                                             AVMetadataObjectTypeUPCECode,   //bar codes
                                                                             AVMetadataObjectTypeEAN8Code,
                                                                             AVMetadataObjectTypeEAN13Code,
                                                                             AVMetadataObjectTypeCode39Code,
                                                                             AVMetadataObjectTypeCode93Code,
                                                                             AVMetadataObjectTypeCode128Code,
                                                                             AVMetadataObjectTypeITF14Code,
                                                                             AVMetadataObjectTypeCode39Mod43Code,
                                                                             AVMetadataObjectTypeInterleaved2of5Code,
                                                                             AVMetadataObjectTypePDF417Code,      //pdf
                                                                             AVMetadataObjectTypeDataMatrixCode, nil]]; //data matrix
    
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
        _codeName=[metadataObj type];
        
        //---------------------
        //      QR Code
        //---------------------
        if([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) //check if an oject read is a valid qr code
        {
            //TODO: Algorithm
            _nextIndex = metadataObj.stringValue.length % 7;
            _codeType=Hero;
            
            //Video capture and display
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            //NEXT SEGUE
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"resultSegue" sender:self];
            });
        }
        
        //---------------------
        //      BARCODES
        //---------------------
        
        //Bacodes may contain numbers, characters and symbols
        //but differently from the qr codes those are usually a set length
        
        /*
         Types of barcodes:
         AVMetadataObjectTypeEAN8Code,
         AVMetadataObjectTypeEAN13Code,
         AVMetadataObjectTypeCode39Code,
         AVMetadataObjectTypeCode93Code,
         AVMetadataObjectTypeCode128Code,
         AVMetadataObjectTypeITF14Code,
         AVMetadataObjectTypeCode39Mod43Code,
         AVMetadataObjectTypeInterleaved2of5Code,
         */
        
        
        if(([[metadataObj type] isEqualToString:AVMetadataObjectTypeUPCECode]) ||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN8Code]) ||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeCode39Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeCode93Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeCode128Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeITF14Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeCode39Mod43Code])||
           ([[metadataObj type] isEqualToString:AVMetadataObjectTypeInterleaved2of5Code]))
        {

            //[_statusLbl performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            //ALGORITHM
            
            NSString* result = [metadataObj stringValue];
            int weaponIdx=0;
            for(int i=0; i<[result length]-1; i++)
            {
                char c = [result characterAtIndex:i];
                
                //If integer
                if(c>='0' && c<='9')
                {
                    weaponIdx +=atoi(&c);
                }
                else
                {
                    if(c>'K')
                        weaponIdx+=17;
                    else
                        weaponIdx+=11;
                }
                
            }
            
            //Passed values
            _nextIndex = weaponIdx % 7;
             _codeType=Weapon;
            
            //Video capture and display
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            //NEXT SEGUE
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"resultSegue" sender:self];
            });
        }
        
        //---------------------
        //      AZTEC
        //---------------------
        
//        if([[metadataObj type] isEqualToString:AVMetadataObjectTypeAztecCode]) //check if an oject read is a valid qr code
//        {
//
//            //Proccess QR code on the main thread
//            //Status label with QR value
//            [_statusLbl performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
//
//            //Video capture and display
//            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
//
//        }
    }
}


//INITIAL SET UP
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initially set flag to false
    _isReading=NO;
    
    _captureSession = nil;
    
    _nextIndex=0;
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
        resultViewController.index = _nextIndex+1;
        resultViewController.type=_codeType;
        resultViewController.codeName=_codeName;
    }
}


@end
