//
//  AllTouchesGestureRecognizer.m
//  Panda
//
//  Created by chai.chai on 2018/12/27.
//  Copyright © 2018 Farfetch. All rights reserved.
//

#import "AllTouchesGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>
#import <Navi/Navi-Swift.h>

@implementation AllTouchesGestureRecognizer
{
    id<NaviProtocol> navigator;
}

- (instancetype)initWith:(id<NaviProtocol>)navigator {
    self = [super initWithTarget:nil action:nil];
    if (self) {
        navigator = navigator;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIView *view = touches.allObjects.firstObject.view;

    NSString * _Nullable actionString = @"null";

    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;

        for (id target in button.allTargets) {

            actionString = [[button actionsForTarget:target forControlEvent:button.allControlEvents] firstObject];
        }

        NSString *className = NSStringFromClass([touches.allObjects.firstObject.view class]);
        actionString = [NSString stringWithFormat:@"%@ \n %@", className, actionString];

        [[NaviManager shared] addEventsNode:className actionString:actionString];

    } else if (view.gestureRecognizers.firstObject) {
        UIGestureRecognizer *gesture = view.gestureRecognizers.firstObject;
        NSMutableArray *targets = [gesture valueForKeyPath:@"_targets"];
        id targetContainer = targets.firstObject;

        SEL action = ((SEL (*)(id, Ivar))object_getIvar)(targetContainer, class_getInstanceVariable([targetContainer class], "_action"));
        actionString = [NSString stringWithFormat:@"%s", sel_getName(action)];

        NSString *className = NSStringFromClass([touches.allObjects.firstObject.view class]);
        actionString = [NSString stringWithFormat:@"%@ \n %@", className, actionString];

         [[NaviManager shared] addEventsNode:className actionString:actionString];
    } else {
        // touch event
    }

    [super touchesCancelled:touches withEvent:event];
}

@end
