//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"
#import "ASCollectionNodeComponent+Private.h"
#import "ASCollectionNodeComponent+Cache.h"
#import "ASCollectionNodeSectionGroupComponent.h"

const CGFloat ASComponentAutomaticDimension = CGFLOAT_MAX;

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


//- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"MUST override!");
    return nil;
}

//- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"MUST override!");
    return nil;
}

@end
