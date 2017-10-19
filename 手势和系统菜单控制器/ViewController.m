//
//  ViewController.m
//  手势和系统菜单控制器
//
//  Created by zhundao on 2017/10/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ViewController.h"
#import "ShowTextView.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()

@property(nonatomic,strong)ShowTextView *textView;
/*! 当前字体大小 */
@property(nonatomic,assign)float currentFont;
/*! 当前缩放大小 */
@property(nonatomic,assign)float currentScale;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentScale = 1;
    _currentFont = 17;
    self.view.backgroundColor = [UIColor colorWithRed:244.f/256.f green:244.f/256.f blue:244.f/256.f alpha:1];
    _textView = [[ShowTextView alloc]init];
    _textView.text = @"我来测试啦";
    [self.view addSubview:_textView];
    [self addGes:_textView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark --- 懒加载



- (void)addGes :(UITextView *)textView{
    /*! 点击 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [textView addGestureRecognizer:tap];
    /*! 平移 */
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    /*! 旋转 */
    UIRotationGestureRecognizer *rota = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    /*! 缩放 */
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [textView addGestureRecognizer:panGes];
        [textView addGestureRecognizer:rota];
    [textView addGestureRecognizer:pinch];
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"跳转编辑器");
}
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            gestureRecognizer.view.layer.borderColor = [UIColor blackColor].CGColor;
            gestureRecognizer.view.layer.borderWidth = 1;
    }if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            gestureRecognizer.view.layer.borderWidth = 0;
    }
    /*! 获取拖拽的偏移值 */
    CGPoint point = [gestureRecognizer translationInView:self.view];
    /*! 改变textview中心点  只允许上下滑动*/
    gestureRecognizer.view.center = CGPointMake(gestureRecognizer.view.center.x+point.x, gestureRecognizer.view.center.y+point.y);
    /*! 手势增量置为零*/
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

/*! 旋转 */
- (void)rotation:(UIRotationGestureRecognizer *)gestureRecognizer{
    //通过transform 进行旋转变换
    _textView.transform = CGAffineTransformRotate(_textView.transform, gestureRecognizer.rotation);
    //将旋转角度 置为 0
    gestureRecognizer.rotation = 0;
}

/*! 缩放 捏合手势*/
- (void)pinch:(UIPinchGestureRecognizer *)gestureRecognizer{

    _currentScale = gestureRecognizer.scale * _currentScale;
    /*! 开始缩放 */
    if (gestureRecognizer.state ==UIGestureRecognizerStateBegan) {
        gestureRecognizer.view.layer.borderColor = [UIColor whiteColor].CGColor;
        gestureRecognizer.view.layer.borderWidth = 1;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        _textView.font = [UIFont systemFontOfSize:17+(_currentScale-1)*20];
        CGSize size ;
        size = [_textView.text boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :_textView.font } context:nil].size;
        _textView.bounds = CGRectMake(0, 0,size.width+20, size.height+20);
    }
    if (gestureRecognizer.state==UIGestureRecognizerStateEnded) {
        gestureRecognizer.view.layer.borderWidth = 0;
    }
    //设置比例 为 1 。下次在这个scale基础上改变
    gestureRecognizer.scale = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
