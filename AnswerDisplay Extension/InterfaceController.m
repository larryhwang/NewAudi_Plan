//
//  InterfaceController.m
//  AnswerDisplay Extension
//
//  Created by Larry on 15/08/2017.
//  Copyright © 2017 Larry. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "TableCell.h"

#define kCellType @"cell"


@interface InterfaceController ()<WCSessionDelegate> {
     WCSession * session;
}
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

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
    
    NSLog(@"WATCH_DATA:%@",session.receivedApplicationContext[@"data"]);
    //分离数据成为数组

    NSArray *arr = session.receivedApplicationContext[@"data"];
    [_table setNumberOfRows:arr.count withRowType:kCellType];
    for (int  i =0; arr.count>i; i++) {
        NSDictionary *tmpDic = arr[i];
        TableCell *row = [_table rowControllerAtIndex:i];
        [row.NoLable setText:[tmpDic objectForKey:@"id_group"]];
        [row.DDLable setText:[tmpDic objectForKey:@"answer"]];
}
}




@end



