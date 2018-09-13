//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

// When width or height is auto, it will use collectionView.size
// When inset lineSpacing itemSpacing is auto, it will use CollectionLayout's property.
extern const CGFloat ASComponentAutomaticDimension;

@class ASCollectionNodeRootComponent;
@protocol ASCollectionNodeComponent <NSObject, ASCollectionDelegateFlowLayout, ASCollectionDataSource, UICollectionViewDelegateFlowLayout>

@end

@interface ASCollectionNodeBaseComponent : NSObject <ASCollectionNodeComponent>

@property (weak, nonatomic, nullable) ASCollectionNodeBaseComponent *superComponent NS_SWIFT_NAME(superComponent);
@property (weak, nonatomic, nullable) ASCollectionNodeRootComponent *rootComponent;

/**
 The collection host by component. It is nil before RootComponent attach to a collectionNode.
 */
@property (readonly, weak, nonatomic, nullable) ASCollectionNode *collectionNode;

/**
 Register cell should be here, and only for register! It may invoke many times.
 */
- (void)prepareCollectionNode NS_REQUIRES_SUPER;

/**
 Life cycle
 Is really need?

 @param component Nil if remove from super component.
 */
//- (void)willMoveToComponent:(ASCollectionNodeBaseComponent * _Nullable)component NS_REQUIRES_SUPER;
//- (void)didMoveToComponent NS_REQUIRES_SUPER;
//- (void)willMoveToRootComponent:(ASCollectionNodeRootComponent * _Nullable)component NS_REQUIRES_SUPER;
//- (void)didMoveToRootComponent NS_REQUIRES_SUPER;

/**
 For ItemComponent, {item, section} is equal to indexPath.
 For SectionComponent, {item, section} is equal to first item's indexPath, or Zero.
 For SectionGroupComponent, item should always be 0, section is the first section in the component.
 */
@property (readonly, nonatomic) NSInteger item;
@property (readonly, nonatomic) NSInteger section;

@end
