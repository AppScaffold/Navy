//
//  AllTouchesGestureRecognizer.h
//  Panda
//
//  Created by chai.chai on 2018/12/27.
//  Copyright © 2018 Farfetch. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NaviProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface AllTouchesGestureRecognizer : UITapGestureRecognizer

- (instancetype)initWith:(id<NaviProtocol>)navigator;

@end

NS_ASSUME_NONNULL_END
