//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeSectionComponent.h"
#import "ASCollectionNodeComponent+Private.h"
#import "ASCollectionNodeComponent+Cache.h"
#import <vector>

@implementation ASCollectionNodeSectionComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineSpacing = ASComponentAutomaticDimension;
        _itemSpacing = ASComponentAutomaticDimension;
        _sectionInset = UIEdgeInsetsMake(ASComponentAutomaticDimension, ASComponentAutomaticDimension, ASComponentAutomaticDimension, ASComponentAutomaticDimension);
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = self.size;
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionNode.view
                              layout:collectionNode.collectionViewLayout
              insetForSectionAtIndex:indexPath.section];
    }
    if (autoWidth) {
        size.width = MAX(collectionNode.frame.size.width - inset.left - inset.right, 0);
    }
    if (autoHeight) {
        size.height = MAX(collectionNode.frame.size.height - inset.top - inset.bottom, 0);
    }
    return CGSizeEqualToSize(size, CGSizeZero) ? ASSizeRangeUnconstrained : ASSizeRangeMake(size);
}


- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    CGSize size = self.headerSize;
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionNode.view
                              layout:collectionNode.collectionViewLayout
              insetForSectionAtIndex:section];
    }
    if (autoWidth) {
        size.width = MAX(collectionNode.frame.size.width - inset.left - inset.right, 0);
    }
    if (autoHeight) {
        size.height = MAX(collectionNode.frame.size.height - inset.top - inset.bottom, 0);
    }
    return CGSizeEqualToSize(size, CGSizeZero) ? ASSizeRangeUnconstrained : ASSizeRangeMake(size);
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
    CGSize size = self.footerSize;
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionNode.view
                              layout:collectionNode.collectionViewLayout
              insetForSectionAtIndex:section];
    }
    if (autoWidth) {
        size.width = MAX(collectionNode.frame.size.width - inset.left - inset.right, 0);
    }
    if (autoHeight) {
        size.height = MAX(collectionNode.frame.size.height - inset.top - inset.bottom, 0);
    }
    return CGSizeEqualToSize(size, CGSizeZero) ? ASSizeRangeUnconstrained : ASSizeRangeMake(size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_lineSpacing == ASComponentAutomaticDimension || isnan(_lineSpacing)) ? ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing : _lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (_itemSpacing == ASComponentAutomaticDimension || isnan(_itemSpacing)) ? ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing : _itemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
    if (_sectionInset.top != ASComponentAutomaticDimension && !isnan(_sectionInset.top)) {
        inset.top = _sectionInset.top;
    }
    if (_sectionInset.left != ASComponentAutomaticDimension && !isnan(_sectionInset.left)) {
        inset.left = _sectionInset.left;
    }
    if (_sectionInset.right != ASComponentAutomaticDimension && !isnan(_sectionInset.right)) {
        inset.right = _sectionInset.right;
    }
    if (_sectionInset.bottom != ASComponentAutomaticDimension && !isnan(_sectionInset.bottom)) {
        inset.bottom = _sectionInset.bottom;
    }
    return inset;
}

@end


@implementation ASCollectionNodeHeaderFooterSectionComponent

- (void)setCollectionNode:(ASCollectionNode *)collectionNode {
    [super setCollectionNode:collectionNode];
    self.headerComponent.collectionNode = collectionNode;
    self.footerComponent.collectionNode = collectionNode;
    self.headerFooterComponent.collectionNode = collectionNode;
}

- (void)setHeaderComponent:(ASCollectionNodeSectionComponent *)headerComponent {
    if (_headerComponent.superComponent == self) _headerComponent.superComponent = nil;
    _headerComponent = headerComponent;
    _headerComponent.superComponent = self;
    if (self.collectionNode) [_headerComponent prepareCollectionNode];
}

- (void)setFooterComponent:(ASCollectionNodeSectionComponent *)footerComponent {
    if (_footerComponent.superComponent == self) _footerComponent.superComponent = nil;
    _footerComponent = footerComponent;
    _footerComponent.superComponent = self;
    if (self.collectionNode) [_footerComponent prepareCollectionNode];
}

- (void)setHeaderFooterComponent:(ASCollectionNodeSectionComponent *)headerFooterComponent {
    if (_headerFooterComponent.superComponent == self) _headerFooterComponent.superComponent = nil;
    _headerFooterComponent = headerFooterComponent;
    _headerFooterComponent.superComponent = self;
    if (self.collectionNode) [_headerFooterComponent prepareCollectionNode];
}

- (void)prepareCollectionNode {
    [super prepareCollectionNode];
    if (self.collectionNode) {
        [_headerFooterComponent prepareCollectionNode];
        [_headerComponent prepareCollectionNode];
        [_footerComponent prepareCollectionNode];
    }
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ASCollectionNodeBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:@selector(collectionNode:nodeForSupplementaryElementOfKind:atIndexPath:)]) {
            return [comp collectionNode:collectionNode nodeForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ASCollectionNodeBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:@selector(collectionNode:nodeForSupplementaryElementOfKind:atIndexPath:)]) {
            return [comp collectionNode:collectionNode nodeForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    NSAssert(false, @"%@ is nil!", kind);
    return nil;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    if ([_headerComponent respondsToSelector:_cmd]) {
        [_headerComponent collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
    if ([_footerComponent respondsToSelector:_cmd]) {
        [_footerComponent collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
    if ([_headerFooterComponent respondsToSelector:_cmd]) {
        [_headerFooterComponent collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingSupplementaryElementWithNode:(ASCellNode *)node
{
    if ([_headerComponent respondsToSelector:_cmd]) {
        [_headerComponent collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
    if ([_footerComponent respondsToSelector:_cmd]) {
        [_footerComponent collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
    if ([_headerFooterComponent respondsToSelector:_cmd]) {
        [_headerFooterComponent collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
    if ([comp respondsToSelector:@selector(collectionNode:sizeRangeForHeaderInSection:)]) {
        return [comp collectionNode:collectionNode sizeRangeForHeaderInSection:section];
    }
    return ASSizeRangeUnconstrained;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
    if ([comp respondsToSelector:@selector(collectionNode:sizeRangeForFooterInSection:)]) {
        return [comp collectionNode:collectionNode sizeRangeForFooterInSection:section];
    }
    return ASSizeRangeUnconstrained;
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:self.description];
    if (self.headerComponent) {
        [desc appendString:@"\n  [Header] "];
        [desc appendString:[[self.headerComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    if (self.footerComponent) {
        [desc appendString:@"\n  [Footer] "];
        [desc appendString:[[self.footerComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    if (self.headerFooterComponent) {
        [desc appendString:@"\n  [HeaderFooter] "];
        [desc appendString:[[self.headerFooterComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    return desc;
}

@end

@implementation ASCollectionNodeItemGroupComponent {
    std::vector<NSInteger> _numberOfItemsCache;
}

- (void)setSubComponents:(NSArray *)subComponents {
    for (ASCollectionNodeBaseComponent *comp in _subComponents) {
        if (comp.superComponent == self) {
            comp.superComponent = nil;
        }
    }
    _subComponents = subComponents;
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

- (ASCollectionNodeBaseComponent *)componentAtItem:(NSInteger)atItem {
    ASCollectionNode *collectionNode = self.collectionNode;
    __block ASCollectionNodeBaseComponent *component = nil;
    if (collectionNode) {
        __block NSInteger item = self.item;
        if (self.dataSourceCacheEnable) {
            __block NSInteger section = -1; // Lazy load section.
            [_subComponents enumerateObjectsUsingBlock:^(ASCollectionNodeBaseComponent *obj, NSUInteger idx, BOOL *stop) {
                NSInteger count = 0;
                if (_numberOfItemsCache.size() > idx) {
                    count = _numberOfItemsCache[idx];
                }
                else {
                    if (section < 0) {
                        section = self.section;
                    }
                    count = [obj collectionNode:collectionNode numberOfItemsInSection:section];
                }
                if (item <= atItem && item+count > atItem) {
                    component = obj;
                    *stop = YES;
                }
                item += count;
            }];
        }
        else {
            NSInteger section = self.section;
            for (ASCollectionNodeBaseComponent *comp in _subComponents) {
                NSInteger count = [comp collectionNode:collectionNode numberOfItemsInSection:section];
                if (item <= atItem && item+count > atItem) {
                    component = comp;
                    break;
                }
                item += count;
            }
        }
    }
    return component;
}

- (NSInteger)firstItemOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    ASCollectionNode *collectionNode = self.collectionNode;
    if (collectionNode) {
        if (self.dataSourceCacheEnable) {
            __block NSInteger item = self.item;
            __block BOOL matched = NO;
            __block NSInteger section = -1; // Lazy load section.
            [_subComponents enumerateObjectsUsingBlock:^(ASCollectionNodeBaseComponent *obj, NSUInteger idx, BOOL *stop) {
                if (obj == subComp) {
                    *stop = YES;
                    matched = YES;
                }
                else {
                    if (_numberOfItemsCache.size() > idx) {
                        item += _numberOfItemsCache[idx];
                    }
                    else {
                        if (section < 0) {
                            section = self.section;
                        }
                        item += [obj collectionNode:collectionNode numberOfItemsInSection:section];
                    }
                }
            }];
            if (matched) {
                return item;
            }
        }
        else {
            NSInteger item = self.item;
            NSInteger section = self.section;
            for (ASCollectionNodeBaseComponent *comp in _subComponents) {
                if (comp == subComp) {
                    return item;
                }
                else {
                    item += [comp collectionNode:collectionNode numberOfItemsInSection:section];
                }
            }
        }
    }
    return 0;
}

- (NSInteger)firstSectionOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    return self.section;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    // hidden if no subComponents
    return self.subComponents.count > 0 ? 1 : 0;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (self.dataSourceCacheEnable) {
        _numberOfItemsCache.clear();
        _numberOfItemsCache.reserve(_subComponents.count);
        for (ASCollectionNodeBaseComponent *comp in _subComponents) {
            NSInteger number = [comp collectionNode:collectionNode numberOfItemsInSection:section];
            count += number;
            _numberOfItemsCache.push_back(number);
        }
    }
    else {
        for (ASCollectionNodeBaseComponent *comp in _subComponents) {
            count += [comp collectionNode:collectionNode numberOfItemsInSection:section];
        }
    }
    return count;
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    return [comp collectionNode:collectionNode nodeForItemAtIndexPath:indexPath];
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldHighlightItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didHighlightItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didUnhighlightItemAtIndexPath:indexPath];
    }
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldSelectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldDeselectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didSelectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didDeselectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:node.indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplayItemWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingItemWithNode:(nonnull ASCellNode *)node
{
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:node.indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingItemWithNode:node];
    }
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode constrainedSizeForItemAtIndexPath:indexPath];
    }
    return ASSizeRangeUnconstrained;
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:[super debugDescription]];
    if (self.subComponents.count) {
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
