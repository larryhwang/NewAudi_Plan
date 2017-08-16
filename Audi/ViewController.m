//
//  ViewController.m
//  Audi
//
//  Created by Larry on 14/08/2017.
//  Copyright © 2017 Larry. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController ()<WCSessionDelegate>


@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;

 @property (nonatomic,strong) NSTimer *DataReques_Timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.DataReques_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(DataRequest) userInfo:nil repeats:YES];

    [self sendMsgTesT];
}




-(void)DataRequest {
    NSLog(@"请求数据");
    NSString *urtString = @"http://39.108.100.69/audi/Request.php";
    NSURL *url = [NSURL URLWithString:urtString];    //字符串转URL
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        
                                        if (data != nil) {
                                            
                                            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                            if ([[dataDic objectForKey:@"sucess"] integerValue]==1) {
                                                NSLog(@"接受到数据");

                                                //4.屏幕显示数据
                                            }else {
                                                NSLog(@"无数据");
                                            }
                                            
                                        }else {
                                            NSLog(@"网页失效");
                                        }
                                        
                                        
                                        }
                                        
     ];
    
    
    // 启动任务
    [task resume];
}


-(void)sendMsgToWatch:(NSArray *) answerArr {
    
    
    
    
}


-(void)sendMsgTesT {
    
    if ([WCSession isSupported]) {
        /*创建Session单例*/
        WCSession * session = [WCSession defaultSession];
        /*指定Session的代理*/
        session.delegate = self;
        /*激活当前Session*/
        [session activateSession];
        /*通过Session发送相关数据(Context就表示想要传递给Watch的数据)*/
        [session updateApplicationContext:@{@"name":@"FUCK"} error:nil];
        
        //[session updateApplicationContext:@{@"name":WcleanData} error:nil];
    }
    
}


@end
