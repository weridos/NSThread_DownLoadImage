//
//  ViewController.m
//  Test
//
//  Created by Lymn on 6/22/16.
//  Copyright © 2016 Andy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.类方法创建线程
    [NSThread detachNewThreadSelector:@selector(downLoadImage) toTarget:self withObject:nil];
    
    //2.实例方法创建线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downLoadImage) object:nil];
    //启动线程
    [thread start];
    
    //3.隐式创建线程
    [self performSelectorInBackground:@selector(downLoadImage) withObject:nil];
    
}
- (void)downLoadImage
{
    NSURL *url = [NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1466565828&di=a807d65289daabb8e92eea622de96ed4&src=http://img.hb.aicdn.com/22fb6e333bf7331fcff6d499315ee6c856d3261426ce3-pbetbV_fw580"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        //返回主线程刷新UI
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
}
- (void)updateUI:(id)object
{
    UIImage *image = (UIImage *)object;
    self.imageView.image = image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
