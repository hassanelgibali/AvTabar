//
//  BaseCardCollectionViewContainerView.m
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/15/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardCollectionViewContainerView.h"

@interface BaseCardCollectionViewContainerView()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    NSMutableDictionary* sizes;
    
    NSMutableDictionary* cells;
}

@end

@implementation BaseCardCollectionViewContainerView

-(void)prepareCells{
    
    cells = [NSMutableDictionary new];
    
    NSIndexPath* indexPath = nil;
    
    BaseCardCollectionViewCell* cell = nil;
    
    for (NSInteger j = 0; j<_numberOfSections; j++) {
        
        NSInteger numberOfRows = [self.delegate numberOfItemsInSection:j];
        
        for (NSInteger i=0; i<numberOfRows; i++) {
            
            indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            
            cell = [self.delegate cellForRowAtIndexPath:indexPath];
            
            [cells setObject:cell forKey:[NSString stringWithFormat:@"%ld-%ld",(long)j,(long)i]];
            
            [self changeSizeTo:cell.card.frame.size forCellAtIndexPath:indexPath];
        }
    }
    
    self.cardsCollectionView.delegate = self;
    
    self.cardsCollectionView.dataSource = self;
    
    [self.cardsCollectionView reloadData];
}

#pragma mark UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.delegate numberOfItemsInSection:section];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.numberOfSections;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [cells objectForKey:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return _horizontalSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return _verticalSpacing;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id result = sizes[[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    
    if(result != nil){
        
        return [result CGSizeValue];
    }
    
    return CGSizeZero;
}

#pragma mark CellSizeChangedDelegate
-(void)changeSizeTo:(CGSize)size forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    id oldSize = sizes[[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    
    if(oldSize == nil ||
       [oldSize CGSizeValue].width != size.width ||
       [oldSize CGSizeValue].height != size.height){
        
        sizes[[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]] = [NSValue valueWithCGSize:size];
        
        [self.cardsCollectionView reloadData];
    }
}

#pragma mark init

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
    
}

-(void)commonInit{
    
    sizes = [NSMutableDictionary new];
}

@end

