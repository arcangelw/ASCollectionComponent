//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"
#import "ASCollectionNodeSectionComponent.h"
#import "ASCollectionNodeSectionGroupComponent.h"

/**
 This component is for status changing.
 For example, a request should has 'Loading', 'Error', 'Empty Data', 'Normal Data'.
 And the component should show 'Loading' when request is loading.
 */
@interface ASCollectionNodeStatusComponent : ASCollectionNodeBaseComponent

/**
 You can change the state by this property.
 You must reloadData by yourself after currentState changed!
 */
@property (strong, nonatomic, nullable) NSString *currentState;
@property (readonly, nonatomic, nullable) ASCollectionNodeBaseComponent *currentComponent;

- (ASCollectionNodeBaseComponent * _Nullable)componentForState:(NSString * _Nullable)state;

/**
 <#Description#>

 @param comp Component for the state
 @param state Nil will do nothing
 */
- (void)setComponent:(ASCollectionNodeBaseComponent * _Nullable)comp forState:(NSString * _Nullable)state;

@end


/**
 Like ASCollectionNodeStatusComponent, but the header and footer will use statusComponent properties,
 not the subComponent's properties.
 */
@interface ASCollectionNodeHeaderFooterStatusComponent : ASCollectionNodeStatusComponent

@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *headerComponent;
@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *footerComponent;
@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *headerFooterComponent;

@end
