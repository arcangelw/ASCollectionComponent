//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASCollectionNodeSectionGroupComponent : ASCollectionNodeBaseComponent

@property (strong, nonatomic, nullable) NSArray<__kindof ASCollectionNodeBaseComponent *> *subComponents;

- (__kindof ASCollectionNodeBaseComponent * _Nullable)componentAtSection:(NSInteger)atSection;
@end

@interface ASCollectionNodeRootComponent : ASCollectionNodeSectionGroupComponent

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;


/**
 Like
 '- (instancetype)initWithCollectionNode:(ASCollectionNode *)collectionNode bind:(BOOL)bind;'
 And bind is YES.
 */
- (instancetype)initWithCollectionNode:(ASCollectionNode *)collectionNode;

/**
 Attach to a collection view. It will override its delegate and dataSource.
 But it will not override scroll delegate.

 @param collectionNode
 @param bind Yes will override delegate and dataSource.
 */
- (instancetype)initWithCollectionNode:(ASCollectionNode *)collectionNode bind:(BOOL)bind;

@end

NS_ASSUME_NONNULL_END
