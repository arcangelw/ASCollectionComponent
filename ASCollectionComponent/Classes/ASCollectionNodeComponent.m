//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"
#import "ASCollectionNodeComponent+Private.h"
#import "ASCollectionNodeComponent+Cache.h"
#import "ASCollectionNodeSectionGroupComponent.h"

const CGFloat ASComponentAutomaticDimension = CGFLOAT_MAX;
const CGSize ASComponentSizeAutomaticDimension = {CGFLOAT_MAX, CGFLOAT_MAX};
const UIEdgeInsets ASComponentInsetsAutomaticDimension = {CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX};

ASSizeRange ASComponentNodeConstrainedSizeForScrollDirection(ASCollectionView *collectionView, CGSize size, ASComponentNodeConstrainedInsetsGetter getter) {
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = getter();
    }
    CGSize miniSize = CGSizeZero;
    CGSize maxSize = collectionView.bounds.size;
    /// 横向布局处理
    if (ASScrollDirectionContainsHorizontalDirection(collectionView.scrollableDirections)) {
        if (autoWidth) {
            maxSize.width = CGFLOAT_MAX;
        } else {
            maxSize.width = size.width;
            miniSize.width = size.width;
        }
        if (autoHeight) {
            maxSize.height -= (inset.top + inset.bottom);
        } else {
            maxSize.height = size.height;
        }
        miniSize.height = maxSize.height;
    } else {
        if (autoWidth) {
            maxSize.width -= (inset.left + inset.right);
        } else {
            maxSize.width = size.width;
        }
        if (autoHeight) {
            maxSize.height = CGFLOAT_MAX;
        } else {
            maxSize.height = size.height;
            miniSize.height = size.height;
        }
        miniSize.width = maxSize.width;
    }
//    return CGSizeEqualToSize(size, CGSizeZero) ? ASSizeRangeZero : ASSizeRangeMake(CGSizeZero, maxSize);
    return ASSizeRangeMake(miniSize, maxSize);
}

CGSize ASComponentViewSizeForScrollDirection(ASCollectionView *collectionView, CGSize size, ASComponentNodeConstrainedInsetsGetter getter) {
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = getter();
    }
    CGSize maxSize = collectionView.bounds.size;
    /// 横向布局处理
    if (ASScrollDirectionContainsHorizontalDirection(collectionView.scrollableDirections)) {
        if (autoWidth) {
            maxSize.width = UICollectionViewFlowLayoutAutomaticSize.width;
            NSCAssert(NO, @"UIKit View 不支持自动计算");
        } else {
            maxSize.width = size.width;
        }
        if (autoHeight) {
            maxSize.height -= (inset.top + inset.bottom);
        } else {
            maxSize.height = size.height;
        }
    } else {
        if (autoWidth) {
            maxSize.width -= (inset.left + inset.right);
        } else {
            maxSize.width = size.width;
        }
        if (autoHeight) {
            maxSize.height = UICollectionViewFlowLayoutAutomaticSize.height;
            NSCAssert(NO, @"UIKit View 不支持自动计算");
        } else {
            maxSize.height = size.height;
        }
    }
    return maxSize;
}

ASCellNode * ASComponentEmptyCellNode() {
    static ASCellNode *cellNode;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNode = [[ASCellNode alloc] init];
    });
    return cellNode;
}

@implementation ASCollectionNodeBaseComponent
@synthesize collectionNode=_collectionNode;
@synthesize dataSourceCacheEnable=_dataSourceCacheEnable;
//@synthesize sizeCacheEnable=_sizeCacheEnable;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSourceCacheEnable = YES;
//        _sizeCacheEnable = YES;
    }
    return self;
}

- (ASCollectionNodeRootComponent *)rootComponent {
    return self.superComponent.rootComponent;
}

- (void)setSuperComponent:(ASCollectionNodeBaseComponent *)superComponent {
    _superComponent = superComponent;
    self.collectionNode = _superComponent.collectionNode;
}

- (ASCollectionNode *)collectionNode {
    return _collectionNode ?: self.superComponent.collectionNode;
}

- (NSInteger)firstItemOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    return 0;
}

- (NSInteger)firstSectionOfSubComponent:(id<ASCollectionNodeComponent>)subComp {
    return 0;
}

- (void)prepareCollectionNode {}

- (void)clearDataSourceCache {}
- (void)clearSizeCache {}

//- (void)willMoveToComponent:(ASCollectionNodeBaseComponent *)component {}
//- (void)didMoveToComponent {}
//- (void)willMoveToRootComponent:(ASCollectionNodeBaseComponent *)component {}
//- (void)didMoveToRootComponent {}

- (NSInteger)item {
    return [self.superComponent firstItemOfSubComponent:self];
}

- (NSInteger)section {
    return [self.superComponent firstSectionOfSubComponent:self];
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 0;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (id)collectionNode:(ASCollectionNode *)collectionNode nodeModelForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
