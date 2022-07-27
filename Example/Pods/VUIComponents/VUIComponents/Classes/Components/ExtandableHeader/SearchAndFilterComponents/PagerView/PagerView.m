//
//  PagerView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/4/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "PagerView.h"
#import "PagerCollectionViewCell.h"
#import <VUIComponents/Utilities.h>

@interface PagerView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    __weak IBOutlet UICollectionView *collectionPagerView;
    NSMutableArray* Buttons;
    __weak IBOutlet UIView *triangleView;
    __weak IBOutlet UIView *triangleContainerView;
    
    __weak IBOutlet NSLayoutConstraint *triangleContainerBGViewWidthConstraint;
    __weak IBOutlet UIScrollView *TriangleContainerScrollView;
   // CGFloat triangleViewLastContentOffset; // save triangleView x postion
    
    __weak IBOutlet NSLayoutConstraint *triangleContainerViewWidthConstraint;
}
@end

@implementation PagerView

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    UIBezierPath* path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, triangleView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(triangleView.bounds.size.width, triangleView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(triangleView.bounds.size.width/2, 0)];
    [path addLineToPoint:CGPointMake(0, triangleView.bounds.size.height)];
    
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = triangleView.bounds;
    mask.path = path.CGPath;
    triangleView.layer.mask = mask;
    
    if (_numberOfPages == 1) {
        
        triangleContainerViewWidthConstraint.constant = self.frame.size.width;
    }else if (_numberOfPages == 2){
        
        triangleContainerViewWidthConstraint.constant = self.frame.size.width/2;
    }else{
        
        triangleContainerViewWidthConstraint.constant = self.frame.size.width/3;
    }
    
    [collectionPagerView reloadData];
}

#pragma mark collectionView Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"PagerCollectionViewCell";
    
    [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[Utilities getPodBundle]] forCellWithReuseIdentifier:cellIdentifier];
    
    PagerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[Utilities getPodBundle]] forCellWithReuseIdentifier:cellIdentifier];
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    cell.text = [NSString stringWithFormat:@"Register %lu", indexPath.row];
    
    cell.actionBlock = ^{
        
        if(self->_selectionBlock != nil){
            
            self.selectionBlock((int)indexPath.row);
        }
        
        [self setCurrentPage:(int)indexPath.row];
    };
    if (_currentPage == indexPath.row ) {
        
        [collectionPagerView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }else{
        
               [cell setSelected:false];
    }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return true;
}
- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender{
    
    return true;
}
- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender{
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_selectionBlock != nil){
        
        self.selectionBlock((int)indexPath.row);
    }
    
    [self setCurrentPage:(int)indexPath.row];
}

//- (void)collectionView:(UICollectionView *)collectionView
//       willDisplayCell:(UICollectionViewCell *)cell
//    forItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (_currentPage == indexPath.row ) {
//        
//         [collectionPagerView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
//        
//    }else{
//        [cell setSelected:false];
//        
//    }
//    
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _numberOfPages;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_numberOfPages == 2) {
        
        return CGSizeMake(collectionPagerView.frame.size.width/2, collectionPagerView.frame.size.width/3);
    }else if (_numberOfPages == 1){
        
        return CGSizeMake(collectionPagerView.frame.size.width, collectionPagerView.frame.size.width/3);
    }else{
    
    return CGSizeMake(collectionPagerView.frame.size.width/3, collectionPagerView.frame.size.width/3);
    }
}

#pragma mark ScrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (collectionPagerView == scrollView) {
        
        TriangleContainerScrollView.contentOffset = collectionPagerView.contentOffset;
    }
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//
//    // save triangleView x postion before scrolling
//    triangleViewLastContentOffset = scrollView.contentOffset.x;
//    NSLog(@"**WillBegin scrollView.contentOffset.x @%f",scrollView.contentOffset.x);
//
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"scrollView.contentOffset.x @%f",scrollView.contentOffset.x);
//
//    CGRect frame = triangleContainerView.frame;
//
//
//
//    if (triangleViewLastContentOffset > scrollView.contentOffset.x) {
//
//        frame.origin.x += triangleViewLastContentOffset;
//
//    }else if(triangleViewLastContentOffset < scrollView.contentOffset.x)
//    {
//        frame.origin.x -= scrollView.contentOffset.x;
//    }
//
//    NSLog(@"frame.origin.x @%f",frame.origin.x);
//    triangleContainerView.frame = frame;
//}

#pragma mark  action
-(void)selectAcionAtIndexPath:(NSIndexPath*)indexPath{
    
    [collectionPagerView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [self scrollTraingleContainerViewAtIndexPath:indexPath];
}

-(void)scrollTraingleContainerViewAtIndexPath:(NSIndexPath *)indexPath{
        
    CGRect frame = triangleContainerView.frame;
    
    CGRect collectionPagerViewframe = [collectionPagerView cellForItemAtIndexPath:indexPath].frame; //convertRect:[collectionPagerView cellForItemAtIndexPath:indexPath].bounds toView:self];
    
    frame.origin.x = collectionPagerViewframe.origin.x;
    [UIView animateWithDuration:0.1 animations:^{
        
        self->triangleContainerView.frame = frame;
    }];
    
}

#pragma mark setter
-(void)setNumberOfPages:(int)numberOfPages{
    
    _numberOfPages = numberOfPages;
    
}

-(void)setCurrentPage:(int)currentPage{
    
    if (0 <= currentPage && currentPage < _numberOfPages) {
        _currentPage = currentPage;
        
        [self selectAcionAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:0]];
    }
}

#pragma mark init
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"PagerView" owner:self options:nil];
    
    collectionPagerView.delegate = self;
    
    collectionPagerView.dataSource = self;
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    collectionPagerView.collectionViewLayout = flow;
    
    [self addSubview:view];
}

@end
