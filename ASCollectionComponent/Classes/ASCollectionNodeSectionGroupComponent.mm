//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeSectionGroupComponent.h"
#import "ASCollectionNodeComponent+Cache.h"
#import "ASCollectionNodeComponent+Private.h"
#import <vector>

@implementation ASCollectionNodeSectionGroupComponent {
    std::vector<NSInteger> _numberOfSectionCache;
}

- (void)setSubComponents:(NSArray *)subComponents {
    for (ASCollectionNodeBaseComponent *comp in _subComponents) {
        if (comp.superComponent == self) {
            comp.superComponent = nil;
        }
    }
    _subComponents = subComponents.copy;
    for (ASCollectionNodeBaseComponent *comp in _subComponents) {
        comp.superComponent = self;
        if (self.collectionNode) {
            [comp prepareCollectionNode];
        }
    }
}

- (void)setCollectionNode:(ASCollectionNode *)collectionNode {
    [super setCollectionNode:collectionNode];
    [_subComponents enumerateObjectsUsingBlock:^(__kindof ASCollectionNodeBaseComponent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCollectionNode:collectionNode];
    }];
}

- (void)prepareCollectionNode {
    [super prepareCollectionNode];
    if (self.collectionNode) {
        for (ASCollectionNodeBaseComponent *comp in _subComponents) {
            [comp prepareCollectionNode];
        }
    }
}

- (NSInteger)firstSectionOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    ASCollectionNode *collectionNode = self.collectionNode;
    if (collectionNode) {
        __block NSInteger section = self.section;
        __block BOOL matched = NO;
        [_subComponents enumerateObjectsUsingBlock:^(ASCollectionNodeBaseComponent *comp, NSUInteger idx, BOOL *stop) {
            if (comp == subComp) {
                matched = YES;
                *stop = YES;
            }
            else {
                // When dataSourceCacheEnable = NO, _numberOfSectionCache.size == 0
                if (_numberOfSectionCache.size() > idx) {
                    section += _numberOfSectionCache[idx];
                }
                else {
                    section += [comp numberOfSectionsInCollectionNode:collectionNode];
                }
            }
        }];
        if (matched) {
            return section;
        }
    }
    return 0;
}

- (ASCollectionNodeBaseComponent *)componentAtSection:(NSInteger)atSection {
    ASCollectionNode *collectionNode = self.collectionNode;
    __block ASCollectionNodeBaseComponent *component = nil;
    if (collectionNode) {
        __block NSInteger section = self.section;
        [_subComponents enumerateObjectsUsingBlock:^(ASCollectionNodeBaseComponent *comp, NSUInteger idx, BOOL *stop) {
            NSInteger count = 0;
            // When dataSourceCacheEnable = NO, _numberOfSectionCache.size == 0
            if (_numberOfSectionCache.size() > idx) {
                count = _numberOfSectionCache[idx];
            }
            else {
                count = [comp numberOfSectionsInCollectionNode:collectionNode];
            }
            if (section <= atSection && section+count > atSection) {
                component = comp;
                *stop = YES;
            }
            section += count;
        }];
    }
    return component;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    NSInteger sections = 0;
    if (self.dataSourceCacheEnable) {
        _numberOfSectionCache.clear();
        _numberOfSectionCache.reserve(_subComponents.count);
        for (ASCollectionNodeBaseComponent *comp in _subComponents) {
            NSInteger number = [comp numberOfSectionsInCollectionNode:collectionNode];
            sections += number;
            _numberOfSectionCache.push_back(number);
        }
    }
    else {
        for (ASCollectionNodeBaseComponent *comp in _subComponents) {
            sections += [comp numberOfSectionsInCollectionNode:collectionNode];
        }
    }
    return sections;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    return [comp collectionNode:collectionNode numberOfItemsInSection:section];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    return [comp collectionNode:collectionNode nodeForItemAtIndexPath:indexPath];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    return [comp collectionNode:collectionNode nodeForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldHighlightItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didHighlightItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didUnhighlightItemAtIndexPath:indexPath];
    }
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldSelectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldDeselectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didSelectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didDeselectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:node.indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplayItemWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingItemWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:node.indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingItemWithNode:node];
    }
}


- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:node.indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingSupplementaryElementWithNode:(nonnull ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:node.indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:indexPath.section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode constrainedSizeForItemAtIndexPath:indexPath];
    }
    return ASSizeRangeUnconstrained;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode sizeRangeForFooterInSection:section];
    }
    return ASSizeRangeUnconstrained;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode sizeRangeForHeaderInSection:section];
    }
    return ASSizeRangeUnconstrained;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = [self componentAtSection:section];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    return 0;
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:self.description];
    if (self.subComponents.count > 0) {
        [desc appendString:@"\n  [SubComponents]"];
        for (ASCollectionNodeBaseComponent *comp in self.subComponents) {
            [desc appendString:@"\n    "];
            NSArray *descs = [comp.debugDescription componentsSeparatedByString:@"\n"];
            [desc appendString:[descs componentsJoinedByString:@"\n    "]];
        }
    }
    return desc;
}

@end

@interface ASCollectionNodeRootComponent ()
//@property (nonatomic, readwrite, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;
@end

@implementation ASCollectionNodeRootComponent
@synthesize collectionNode = _collectionNode;

- (void)dealloc
{
    _collectionNode.delegate = nil;
    _collectionNode.dataSource = nil;
    _scrollDelegate = nil;
}

- (instancetype)initWithCollectionNode:(ASCollectionNode *)collectionNode {
    return [self initWithCollectionNode:collectionNode bind:YES];
}

- (instancetype)initWithCollectionNode:(ASCollectionNode *)collectionNode bind:(BOOL)bind
{
    self = [super init];
    if (self) {
        self.collectionNode = collectionNode;
        if (bind) {
            self.scrollDelegate = collectionNode.delegate;
            collectionNode.dataSource = self;
            collectionNode.delegate = self;
        }
    }
    return self;
}

- (ASCollectionNodeBaseComponent *)superComponent {
    return nil;
}

- (ASCollectionNodeRootComponent *)rootComponent {
    return self;
}

- (NSInteger)section {
    return 0;
}

- (NSInteger)item {
    return 0;
}

- (void)reloadData {
    [self.collectionNode reloadData];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_scrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_scrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_scrollDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_scrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [_scrollDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_scrollDelegate scrollViewDidScrollToTop:scrollView];
    }
}

@end
