//
//  ASMainComponent.m
//  ASCollectionComponent_Example
//
//  Created by 吴哲 on 2018/9/11.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASMainComponent.h"

@implementation ASHeaderComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.headerSize = CGSizeMake(ASComponentAutomaticDimension, 35.f);
    }
    return self;
}

- (void)prepareCollectionNode
{
    [super prepareCollectionNode];
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ASCellNode *node = [[ASCellNode alloc] init];
//        node.backgroundColor = UIColor.redColor;
        node.style.preferredSize = (CGSize){30.f,30.f};
        return node;
    }
    return nil;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    if ([node.supplementaryElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        node.backgroundColor = UIColor.redColor;
    }
}

@end

@implementation ASFooterComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.headerSize = CGSizeMake(ASComponentAutomaticDimension, 35.f);
    }
    return self;
}

- (void)prepareCollectionNode
{
    [super prepareCollectionNode];
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ASCellNode *node = [[ASCellNode alloc] init];
        //        node.backgroundColor = UIColor.redColor;
        node.style.preferredSize = (CGSize){30.f,30.f};
        return node;
    }
    return nil;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    if ([node.supplementaryElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        node.backgroundColor = UIColor.blueColor;
    }
}
@end

@implementation ASMainComponent
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.size = CGSizeMake(100.f, 75.f);
        self.itemSpacing = 10.f;
        self.lineSpacing = 10.f;
        self.sectionInset = UIEdgeInsetsMake(20.f, 15.f, 20.f, 15.f);
        self.headerComponent = [[ASHeaderComponent alloc] init];
        self.footerComponent = [[ASFooterComponent alloc] init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode
{
    return 5;
}
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode *node = [[ASCellNode alloc] init];
    node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(225)/225.f green:arc4random_uniform(225)/225.f blue:arc4random_uniform(225)/225.f alpha:1.f];
//    node.style.maxSize = (CGSize){100.f,75.f};
    node.style.maxWidth = ASDimensionMakeWithPoints(100.f);
    node.style.maxHeight = ASDimensionMakeWithPoints(75.f);
    return node;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(ASCellNode *)node
{
    
}

@end
