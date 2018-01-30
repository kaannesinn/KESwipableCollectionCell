//
//  CollectionViewCell.h
//  DenemeCollectionInScroll
//
//  Created by Kaan Esin on 29.01.2018.
//  Copyright © 2018 Kaan Esin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KESwipableCollectionCell : UICollectionViewCell  <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;

@end
