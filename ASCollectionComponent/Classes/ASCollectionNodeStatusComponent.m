//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeStatusComponent.h"
#import "ASCollectionNodeComponent+Private.h"

@implementation ASCollectionNodeStatusComponent {
    NSMutableDictionary<NSString *, ASCollectionNodeBaseComponent *> *_componentDict;
@protected
    NSUInteger _numberOfSections; // cache
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _componentDict = [NSMutableDictionary new];
    }
    return self;
}

- (NSInteger)firstItemOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    return self.item;
}

- (NSInteger)firstSectionOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    return self.section;
}

- (void)setCollectionNode:(ASCollectionNode *)collectionNode {
    [super setCollectionNode:collectionNode];
    [_componentDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, ASCollectionNodeBaseComponent * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj setCollectionNode:collectionNode];
    }];
}

- (void)prepareCollectionNode {
    [super prepareCollectionNode];
    if (self.collectionNode) {
        [_componentDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, ASCollectionNodeBaseComponent * _Nonnull obj, BOOL * _Nonnull stop) {
            [obj prepareCollectionNode];
        }];
    }
}

- (ASCollectionNodeBaseComponent *)currentComponent {
    return [self componentForState:self.currentState];
}

- (void)setComponent:(ASCollectionNodeBaseComponent *)comp forState:(NSString *)state {
    if (state) {
        ASCollectionNodeBaseComponent *oldComp = _componentDict[state];
        if (comp) {
            if (oldComp.superComponent == self) _componentDict[state].superComponent = nil;
            comp.superComponent = self;
            [_componentDict setObject:comp forKey:state];
            if (self.collectionNode) {
                [comp prepareCollectionNode];
            }
        }
        else {
            if (oldComp.superComponent == self) _componentDict[state].superComponent = nil;
            [_componentDict removeObjectForKey:state];
        }
    }
}

- (ASCollectionNodeBaseComponent *)componentForState:(NSString *)state {
    if (state) {
        ASCollectionNodeBaseComponent *comp = [_componentDict objectForKey:state];
        return comp;
    }
    return nil;
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    _numberOfSections = [self.currentComponent numberOfSectionsInCollectionNode:collectionNode];
    return _numberOfSections;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return [self.currentComponent collectionNode:collectionNode numberOfItemsInSection:section];
}

- (id)collectionNode:(ASCollectionNode *)collectionNode nodeModelForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    return [comp collectionNode:collectionNode nodeModelForItemAtIndexPath:indexPath];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    return [comp collectionNode:collectionNode nodeForItemAtIndexPath:indexPath];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    return [comp collectionNode:collectionNode nodeForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}


- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldHighlightItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didHighlightItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didUnhighlightItemAtIndexPath:indexPath];
    }
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldSelectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode shouldDeselectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didSelectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didDeselectItemAtIndexPath:indexPath];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplayItemWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingItemWithNode:(nonnull ASCellNode *)node
{
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingItemWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingSupplementaryElementWithNode:(nonnull ASCellNode *)node {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode constrainedSizeForItemAtIndexPath:indexPath];
    }
    return ASSizeRangeZero;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode sizeRangeForFooterInSection:section];
    }
    return ASSizeRangeZero;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionNode:collectionNode sizeRangeForHeaderInSection:section];
    }
    return ASSizeRangeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    return 0;
}

#pragma mark - Interop

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    return [comp collectionView:collectionView cellForItemAtIndexPath:indexPath];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    return [comp collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}


- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }
}


- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = self.currentComponent;
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didEndDisplayingSupplementaryView:view forElementOfKind:elementKind atIndexPath:indexPath];
    }
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:self.description];
    if (_componentDict.count > 0) {
        [_componentDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, ASCollectionNodeBaseComponent * _Nonnull obj, BOOL * _Nonnull stop) {
            [desc appendString:@"\n  "];
            [desc appendString:[key isEqualToString:self.currentState] ? @"*" : @"-"];
            [desc appendString:@"["];
            [desc appendString:key];
            [desc appendString:@"] "];
            [desc appendString:[[obj.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
        }];
    }
    return desc;
}

@end


@implementation ASCollectionNodeHeaderFooterStatusComponent

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

- (void)setCollectionNode:(ASCollectionNode *)collectionNode {
    [super setCollectionNode:collectionNode];
    self.headerComponent.collectionNode = collectionNode;
    self.footerComponent.collectionNode = collectionNode;
    self.headerFooterComponent.collectionNode = collectionNode;
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
    return nil;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section {
    // header appear at first component
    if (self.section == section) {
        ASCollectionNodeBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionNode:collectionNode sizeRangeForHeaderInSection:section];
        }
    }
    return ASSizeRangeZero;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section {
    // footer appear at last component
    if (self.section + _numberOfSections - 1 == section) {
        ASCollectionNodeBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionNode:collectionNode sizeRangeForFooterInSection:section];
        }
    }
    return ASSizeRangeZero;
}


- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    ASCollectionNodeBaseComponent *comp = nil;
    NSString *elementKind = node.supplementaryElementKind;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        comp = _headerComponent ?: _headerFooterComponent;
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        comp = _footerComponent ?: _headerFooterComponent;
    }
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode willDisplaySupplementaryElementWithNode:node];
    }
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didEndDisplayingSupplementaryElementWithNode:(ASCellNode *)node
{
    ASCollectionNodeBaseComponent *comp = nil;
    NSString *elementKind = node.supplementaryElementKind;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        comp = _headerComponent ?: _headerFooterComponent;
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        comp = _footerComponent ?: _headerFooterComponent;
    }
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionNode:collectionNode didEndDisplayingSupplementaryElementWithNode:node];
    }
}

#pragma mark - Interop

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ASCollectionNodeBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ASCollectionNodeBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    return nil;
}

- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // header appear at first component
    if (self.section == section) {
        ASCollectionNodeBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
        }
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    // footer appear at last component
    if (self.section + _numberOfSections - 1 == section) {
        ASCollectionNodeBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:_cmd]) {
            return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
        }
    }
    return CGSizeZero;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        comp = _headerComponent ?: _headerFooterComponent;
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        comp = _footerComponent ?: _headerFooterComponent;
    }
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    ASCollectionNodeBaseComponent *comp = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        comp = _headerComponent ?: _headerFooterComponent;
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        comp = _footerComponent ?: _headerFooterComponent;
    }
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didEndDisplayingSupplementaryView:view forElementOfKind:elementKind atIndexPath:indexPath];
    }
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:[super debugDescription]];
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

