//
//  UICollectionSectionHeadersPinToVisibleBoundsLayout.h
//  ASCollectionComponent_Example
//
//  Created by 吴哲 on 2018/9/12.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASCollectionSectionPinToVisibleBoundsLayout : UICollectionViewFlowLayout
/// needSectionHeadersPinToVisibleBounds
@property(nonatomic ,assign) BOOL needSectionHeadersPinToVisibleBounds;
/// needSectionFootersPinToVisibleBounds
@property(nonatomic ,assign) BOOL needSectionFootersPinToVisibleBounds;
@end
