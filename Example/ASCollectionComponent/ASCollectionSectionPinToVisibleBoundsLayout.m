//
//  UICollectionSectionHeadersPinToVisibleBoundsLayout.m
//  ASCollectionComponent_Example
//
//  Created by 吴哲 on 2018/9/12.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionSectionPinToVisibleBoundsLayout.h"

@implementation ASCollectionSectionPinToVisibleBoundsLayout

- (void)setNeedSectionHeadersPinToVisibleBounds:(BOOL)needSectionHeadersPinToVisibleBounds
{
    _needSectionHeadersPinToVisibleBounds = needSectionHeadersPinToVisibleBounds;
    if (@available(iOS 9.0, *)) {
        self.sectionHeadersPinToVisibleBounds = _needSectionHeadersPinToVisibleBounds;
    }
}

- (void)setNeedSectionFootersPinToVisibleBounds:(BOOL)needSectionFootersPinToVisibleBounds
{
    _needSectionFootersPinToVisibleBounds = needSectionFootersPinToVisibleBounds;
    if (@available(iOS 9.0, *)) {
        self.sectionFootersPinToVisibleBounds = _needSectionFootersPinToVisibleBounds;
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray<UICollectionViewLayoutAttributes *> * superLayoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    /// iOS9以上 直接使用系统布局
    if (@available(iOS 9.0, *)) return superLayoutAttributes;

    /// 未设置 直接返回系统布局
    if (!_needSectionHeadersPinToVisibleBounds && !_needSectionFootersPinToVisibleBounds) return superLayoutAttributes;
  
    /// 获取屏幕内所有非SupplementaryView布局
    __block NSMutableArray<UICollectionViewLayoutAttributes *> *newLayoutAttributes = [superLayoutAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"representedElementCategory != %@",@(UICollectionElementCategorySupplementaryView)]].mutableCopy;
    
    /// 遍历屏幕内所有显示的section
    __block NSMutableIndexSet *sections = [NSMutableIndexSet indexSet];
    [[NSSet setWithArray:[superLayoutAttributes valueForKeyPath:@"indexPath.section"]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [sections addIndex:[obj integerValue]];
    }];
    
    /// 悬浮布局设置所有屏幕内所有section的SupplementaryView
    __weak __typeof(&*self)weakSelf = self;
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];

        UICollectionViewLayoutAttributes *attributes = nil;
        /// 如果需要header悬浮 对header重新布局
        if (weakSelf.needSectionHeadersPinToVisibleBounds) {
            attributes = [weakSelf customLayoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            if (attributes) {
                [newLayoutAttributes addObject:attributes];
            }
        }
        /// 如果需要footer悬浮 对footer重新布局
        if (weakSelf.needSectionFootersPinToVisibleBounds) {
            attributes = [weakSelf customLayoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
            if (attributes) {
                [newLayoutAttributes addObject:attributes];
            }
        }
    }];
    
    /// 没有悬浮需求 保留原始布局
    
    if (!_needSectionHeadersPinToVisibleBounds) {
        
        [newLayoutAttributes addObjectsFromArray:[superLayoutAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"representedElementKind == %@",UICollectionElementKindSectionHeader]]];
    }
    if (!_needSectionFootersPinToVisibleBounds) {

        [newLayoutAttributes addObjectsFromArray:[superLayoutAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"representedElementKind == %@",UICollectionElementKindSectionFooter]]];
    }
    return newLayoutAttributes.copy;
}

- (UICollectionViewLayoutAttributes *)customLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if (attributes) {
        [self layoutSectionAttributes:attributes bySupplementaryViewOfKind:elementKind];
    }
    return  attributes;
}

- (void)layoutSectionAttributes:(UICollectionViewLayoutAttributes *)attributes bySupplementaryViewOfKind:(NSString *)kind
{
    NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
    /// 没有item 不进行布局
    if (numberOfItemsInSection < 1) return;
    
    NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
    NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attributes.indexPath.section];
    UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
    //cell有值，则获取第一个cell和最后一个cell的结构信息
    firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
    lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];

    /// 是否纵向
    BOOL isVertical = self.scrollDirection == UICollectionViewScrollDirectionVertical;
    BOOL isHeader = [kind isEqualToString:UICollectionElementKindSectionHeader];
    
    UIEdgeInsets sectionInset = self.sectionInset;
    if ([self.collectionView.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)] && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        sectionInset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:attributes.indexPath.section];
    }
    
    /// 获取当前header的frame
    CGRect rect = attributes.frame;
    
    CGFloat min = isVertical ? CGRectGetMinY(firstItemAttributes.frame) : CGRectGetMinX(firstItemAttributes.frame);
    CGFloat max = isVertical ? CGRectGetMaxY(lastItemAttributes.frame) : CGRectGetMaxX(lastItemAttributes.frame);
    
    min -= isVertical ? sectionInset.top : sectionInset.left;
    max += isVertical ? sectionInset.bottom : sectionInset.right;
    
    CGFloat offset = isVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x;
    
    CGFloat rectOffset = isVertical ? CGRectGetHeight(rect) : CGRectGetWidth(rect);
    
    if (isHeader) {
        min -= rectOffset;
        max -= rectOffset;
    }else{
        offset += isVertical ? CGRectGetHeight(self.collectionView.frame): CGRectGetWidth(self.collectionView.frame);
        offset -= rectOffset;
    }
    
    if (offset < min) {
        isVertical ? (rect.origin.y = min) : (rect.origin.x = min);
    }else if (offset > max) {
        isVertical ? (rect.origin.y = max) : (rect.origin.x = max);
    }else {
        isVertical ? (rect.origin.y = offset) : (rect.origin.x = offset);
    }

    attributes.frame = rect;
    attributes.zIndex = 252;
}

@end
