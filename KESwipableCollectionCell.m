//
//  CollectionViewCell.m
//  DenemeCollectionInScroll
//
//  Created by Kaan Esin on 29.01.2018.
//  Copyright © 2018 Kaan Esin. All rights reserved.
//

#import "KESwipableCollectionCell.h"
#import "CollectionViewController.h"

@implementation KESwipableCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
//    self.swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
//    self.swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    self.swipeRecognizer.delegate = self;
//    [self addGestureRecognizer:self.swipeRecognizer];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    self.panRecognizer.delegate = self;
    [self addGestureRecognizer:self.panRecognizer];
    
    return [super initWithFrame:frame];
}
//-(void)swiped:(UISwipeGestureRecognizer*)sender{
//    CollectionViewCell *cell = (CollectionViewCell*)((UISwipeGestureRecognizer  *)sender).view;
//    [UIView animateWithDuration:0.25 animations:^{
//        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
//            cell.frame = CGRectMake(-100, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//        }
//        else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
//            cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//        }
//    }];
//}
-(void)panned:(UIPanGestureRecognizer*)sender{
//    CollectionViewCell *cell = (CollectionViewCell*)((UIPanGestureRecognizer*)sender).view;
//    CGPoint touchPoint = [sender locationInView:cell.superview];
//    NSLog(@"touchPoint:%f",touchPoint.x);
   
    if (sender.state == UIGestureRecognizerStateBegan) {

    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self setNeedsLayout];
    }
    else {
        if ([sender velocityInView:self].x > 500) {
//            UICollectionView *collection = (UICollectionView*)self.superview;
//            NSIndexPath *indexPath = [collection indexPathForItemAtPoint:self.center];
//            [((UICollectionView*)cell.superview) collectionView:collection performAction:@selector(panned:) forItemAtIndexPath:indexPath withSender:nil];
        }
        else {
            [UIView animateWithDuration:0.2 animations:^{
                [self setNeedsLayout];
                [self layoutIfNeeded];
            }];
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGPoint translation = [self.panRecognizer translationInView:self];
    NSLog(@"translation:%f",translation.x);
    KESwipableCollectionCell *cell = (KESwipableCollectionCell*)self.panRecognizer.view;
    
    if (translation.x > 0) {//it is for setting cell's frame to its default position and keeping it's x-value of 0
        [UIView animateWithDuration:0.2 animations:^{
            cell.frame = CGRectMake(0, cell.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
        }];
        return;
    }
    
    if (self.panRecognizer.state == UIGestureRecognizerStateChanged) {//it is for translating cell's frame
        cell.frame = CGRectMake(translation.x, cell.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }
    else if (self.panRecognizer.state == UIGestureRecognizerStateEnded) {// it is for when cell's position is on between default and translated position, it will be translated to -100 and if cell is panned more, it will be translated to -100
        if ((cell.frame.origin.x < 0 && cell.frame.origin.x > - 100) || translation.x < - 100) {
            [UIView animateWithDuration:0.2 animations:^{
                cell.frame = CGRectMake(-100, cell.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
            }];
        }
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
