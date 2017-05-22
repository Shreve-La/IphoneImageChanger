//
//  ViewController.m
//  NSurlSession
//
//  Created by swcl on 2017-05-22.
//  Copyright © 2017 Shreve LaFramenta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic, strong) NSString *lastUrl;
@property (nonatomic, strong) NSString *randomUrl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lastUrl = @"http://imgur.com/bktnImE.png";
    NSURL *url = [NSURL URLWithString: self.lastUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }];
                                              
    
    [downloadTask resume];
    
}
- (IBAction)randomImage:(id)sender {

    do {
        NSArray <NSString *> *images = @[@"http://imgur.com/bktnImE.png", @"http://imgur.com/zdwdenZ.png", @"http://imgur.com/CoQ8aNl.png", @"http://imgur.com/2vQtZBb.png", @"http://imgur.com/y9MIaCS.png"];
    int randNum = arc4random_uniform(5);
    self.randomUrl = images[randNum];
    } while ([self.randomUrl isEqualToString:(self.lastUrl)]);

    self.lastUrl = self.randomUrl;
    
    NSURL *url = [NSURL URLWithString: self.randomUrl];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }];
    
    
    [downloadTask resume];

    
    
}





@end
