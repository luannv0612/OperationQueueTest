//
//  ViewController.m
//  OperationQueueTest
//
//  Created by luannv on 3/21/18.
//  Copyright © 2018 luannv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSOperationQueue *queueCancel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self config];
}
- (IBAction)btnRunClick:(id)sender {
    [self countInBlockOperation];
    [self countOnThreadInBlockOperation];
}
- (IBAction)btnCancelClick:(id)sender {
    [queueCancel cancelAllOperations];
}

- (void)config {
    queueCancel = [[NSOperationQueue alloc] init];
    
}

- (void)countInBlockOperation {
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        for (int i = 100; i < 200; i++) {
            NSLog(@"%d", i);
            sleep(1);
        }
    }];
     [queueCancel addOperation:operation];
}

- (void)countOnThreadInBlockOperation {
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    [operation addExecutionBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 100; i++) {
                NSLog(@"Count in Thread on Block Operation: %d", i);
                sleep(1);
            }
        });
    }];
   [queueCancel addOperation:operation];
}

- (void)downloadImage {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
