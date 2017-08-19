//
//  ViewController.m
//  Audi
//
//  Created by Larry on 14/08/2017.
//  Copyright © 2017 Larry. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "JPUSHService.h"

@interface ViewController ()<WCSessionDelegate>


@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;

 @property (nonatomic,strong) NSTimer *DataReques_Timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.DataReques_Timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(DataRequest) userInfo:nil repeats:YES];


}




-(void)DataRequest {
    NSLog(@"请求数据");
    NSString *urtString = @"http://39.108.100.69:8080/WEB3/dataRequest?token=asedw4erw1AF4rvdf&action=request";
    NSURL *url = [NSURL URLWithString:urtString];    //字符串转URL
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        if (data != nil) {
                                            NSArray *Arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                            [self sendMsgToWatch:Arr];
                                                //4.屏幕显示数据
                                            }else {
                                                NSLog(@"无数据");
                                            }
                                        }
                                        
     ];
    // 启动任务
    [task resume];
}


-(void)sendMsgToWatch:(NSArray *) answerArr {
    if ([WCSession isSupported]) {
        /*创建Session单例*/
        WCSession * session = [WCSession defaultSession];
        /*指定Session的代理*/
        session.delegate = self;
        /*激活当前Session*/
        [session activateSession];
        /*通过Session发送相关数据(Context就表示想要传递给Watch的数据)*/

        [session updateApplicationContext:@{@"data":answerArr} error:nil];
        
    }

    
    
}




@end
