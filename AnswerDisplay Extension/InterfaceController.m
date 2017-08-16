//
//  InterfaceController.m
//  AnswerDisplay Extension
//
//  Created by Larry on 15/08/2017.
//  Copyright © 2017 Larry. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController ()<WCSessionDelegate> {
     WCSession * session;
}
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *TestInfoLab;

@end


@implementation InterfaceController


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];

    // Configure interface objects here.
}




- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}




- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



- (IBAction)Action {
    
    NSLog(@"WATCH_DATA:%@",session.receivedApplicationContext[@"name"]);
    //分离数据成为数组
    
    NSString *tempALl = session.receivedApplicationContext[@"name"];
    [_TestInfoLab setText:tempALl];
    
}




@end



