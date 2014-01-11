//
//  FDViewController.m
//  FlipDemo
//
//  Created by jorf on 1/11/14.
//  Copyright (c) 2014 Jeff Davis. All rights reserved.
//

#import "FDViewController.h"

@interface FDViewController () <UIGestureRecognizerDelegate>
{
@private
    NSUInteger _colorIndex;
    UIImageView* _imageView;
}
@end

static NSArray* _colors = nil;

@implementation FDViewController

+ (void)initialize
{
    if (self == [FDViewController class])
    {
        _colors = @[ [UIColor whiteColor], [UIColor grayColor], [UIColor blackColor], [UIColor redColor], [UIColor brownColor],
                      [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor] ];
    }
}

- (void)loadView
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    CGRect frame = [[UIScreen mainScreen] bounds];
    view.frame = frame;
    self.view = view;

    [self didTap:nil];  // Init background color.

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"Tap to rotate background color.";
    label.font = [UIFont fontWithName:@"Helvetica" size:20];
    [label sizeToFit];

    CGRect labelFrame = label.frame;
    labelFrame.origin.x = CenterDim(CGRectGetWidth(frame), CGRectGetWidth(labelFrame));
    labelFrame.origin.y = 10;
    label.frame = labelFrame;
    [self.view addSubview:label];

    UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    bottomLabel.text = @"Double Tap image to reset.";
    bottomLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    [bottomLabel sizeToFit];

    labelFrame = bottomLabel.frame;
    labelFrame.origin.x = CenterDim(CGRectGetWidth(frame), CGRectGetWidth(labelFrame));
    labelFrame.origin.y = CGRectGetHeight(frame) - CGRectGetHeight(labelFrame) - 10;
    bottomLabel.frame = labelFrame;
    [self.view addSubview:bottomLabel];


    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];

    UIImage* image = [UIImage imageNamed:@"apple.jpg"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    [view addSubview:_imageView];

    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:doubleTap];

    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:pan];

    // Set the anchor point to the layer's left edge, and adjust the view's center to compensate.
    CGRect imageFrame = _imageView.frame;
    imageFrame.origin.y = CenterDim(CGRectGetHeight(frame), CGRectGetHeight(imageFrame));
    _imageView.layer.anchorPoint = CGPointMake(0, 0.5);
    _imageView.center = CGPointMake(0, imageFrame.origin.y + CGRectGetHeight(imageFrame) / 2);
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didPan:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan translationInView:[_imageView superview]];
    CGFloat gamma = (point.x - 0) / CGRectGetWidth([_imageView superview].bounds);
    CATransform3D transform =  CATransform3DIdentity;
    transform.m34 = -1.0f / 500.0f;

    transform = CATransform3DRotate(transform, -M_PI_2 * gamma, 0, 1, 0);
    _imageView.layer.transform = transform;
}

- (void)didTap:(UITapGestureRecognizer*)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [_colors objectAtIndex:_colorIndex];
    }];
    _colorIndex = (_colorIndex + 1) % [_colors count];
}

- (void)didDoubleTap:(UITapGestureRecognizer*)doubleTap
{
    _imageView.layer.transform = CATransform3DIdentity;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return [touch.view isEqual:gestureRecognizer.view];
}

@end
