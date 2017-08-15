//
//  ViewController.m
//  Audi
//
//  Created by Larry on 14/08/2017.
//  Copyright © 2017 Larry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;

 @property (nonatomic,strong) NSTimer *DataReques_Timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
self.DataReques_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(DataRequest) userInfo:nil repeats:YES];


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


@end
