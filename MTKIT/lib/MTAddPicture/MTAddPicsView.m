//
//  MTAddPicsView.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/8/2.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTAddPicsView.h"
#import "MessageReadManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define KImageY 0
#define kMargin 12
@interface MTAddPicsView()<ACActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MTAddimgCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak)  UIImageView *addImg;//加号图片

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MTAddPicsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.viewController = [self viewController];
        self.maxPhoto = 9;
        [self setupPhotoView];

    }
    return self;
}

#pragma mark - 图片的view
- (void)setupPhotoView {
    CGFloat imageH = (ScreenWidth - 5 * kMargin) * 0.25;
    [self addSubview:self.collectionView];
    UIImageView *addImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_send_addImage"]];
    addImg.userInteractionEnabled = YES;
    [addImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImgIBAction)]];
    addImg.frame = CGRectMake(kMargin ,KImageY + kMargin , imageH, imageH);
    _addImg = addImg;
    [self addSubview:_addImg];
}

- (void)addImgIBAction{

    [MTTools_MM keyboardRetracting];
    [self openBtnClick];
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选取"] actionSheetBlock:^(NSInteger buttonIndex) {
        if (self.dataSource.count>=_maxPhoto) {
            NSString *tempNum = [NSString stringWithFormat:@"%ld",_maxPhoto];
            NSString *tempToast = [MTToastMaxImg stringByReplacingOccurrencesOfString:@"9" withString:tempNum];
            [[Toast shareToast] makeText:tempToast aDuration:1];
            return ;
        }
        if(buttonIndex == 0){
            [self firstBtnClick];

            //拍照按钮
#if !TARGET_IPHONE_SIMULATOR
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.view.backgroundColor = [UIColor whiteColor];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            [self.viewController presentViewController:ipc animated:YES completion:nil];
#endif
        }
        if(buttonIndex == 1) {
            [self secondBtnClick];
            if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
                ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                    if (stop) {
                        [self setupTZImageVCNumber:_maxPhoto];
                    }
                    *stop = TRUE;
                } failureBlock:^(NSError *error) {
                    [self setupTZImageVCNumber:_maxPhoto];

                }];
            }else{
                [self setupTZImageVCNumber:_maxPhoto-self.dataSource.count];
            }

        }
    }];
    [actionSheet show];
}


- (NSMutableArray *)dataSource {

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTAddimgCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTAddimgCell" forIndexPath:indexPath];
    MTAddImgModel *model = self.dataSource[indexPath.item];
    cell.delegate = self;
    cell.imageModel = model;

    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [self.dataSource objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.dataSource insertObject:objc atIndex:destinationIndexPath.item];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (ScreenWidth-kMargin*5)*0.25;
        layout.itemSize = CGSizeMake(itemWidth,itemWidth);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kMargin ,KImageY + kMargin, ScreenWidth-kMargin*2, 400) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        [_collectionView registerClass:[MTAddimgCell class] forCellWithReuseIdentifier:@"MTAddimgCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [_collectionView addGestureRecognizer:longGesture];

    }
    return _collectionView;
}

#pragma mark - 删除内容
- (void)delImageView:(MTAddImgModel *)model {

    [self.dataSource removeObject:model];
    [self.collectionView reloadData];
    [self resetAddImgFrame];
}

#pragma mark - 进入图片浏览器
- (void)imageViewTap:(MTAddImgModel *)imageModel {

    NSInteger itemIndex = 0;
    NSMutableArray *images = [NSMutableArray array];

    for (NSInteger index = 0; index < self.dataSource.count; index++) {
        MTAddImgModel *model = self.dataSource[index];
        if ([imageModel isEqual:model]) {
            itemIndex = index;
        }
        [images addObject:model.image];
    }
    
    [[MessageReadManager defaultManager] showBrowserWithImages:images currentIndex:itemIndex forward:nil];
}

//相册选择器
- (void)setupTZImageVCNumber:(NSInteger)photoNum{

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:photoNum columnNumber:4 delegate:nil pushPhotoPickerVc:true type:TZImagePickerTypeCircle];
//    imagePickerVc.
    // 显不显示视频
    imagePickerVc.allowPickingVideo = NO;
    __weak typeof(self) weakSelf = self;
    // 图片选择完的回调
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            MTAddImgModel *model = [[MTAddImgModel alloc] init];
            model.image = image;
            [weakSelf.dataSource addObject:model];
        }
        [self.collectionView reloadData];
        [self resetAddImgFrame];
    }];
    // 视频选择完的回调
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage,id asset) {

    }];
    [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)resetAddImgFrame{

    CGFloat btnW = (ScreenWidth - 5 * kMargin) * 0.25;
    CGFloat addImgY = KImageY;
    if(_dataSource.count < _maxPhoto && self.addBtnHidden == NO){
        NSInteger imgRow  = _dataSource.count%4;
        NSInteger imgLine = _dataSource.count/4;
        _addImg.frame = CGRectMake(imgRow * (btnW + kMargin) + kMargin, kMargin + addImgY + (kMargin + btnW) * imgLine, btnW, btnW);
        _addImg.hidden = NO;
    }else{
        _addImg.hidden = YES;
    }
}

/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)setAddBtnHidden:(BOOL)addBtnHidden {

    _addBtnHidden = addBtnHidden;
    _addImg.hidden = _addBtnHidden;

}

/**
 获取所有的图片
 */
- (NSArray *)getImages {

    NSMutableArray *images = [NSMutableArray array];
    for (MTAddImgModel * model in self.dataSource) {
        [images addObject:model.image];
    }

    return images;
}

/**
 获取所有的图片 以模型的形式
 */
- (NSArray *)getImagesModel {

    return self.dataSource;
}

/**
 当没有+号按钮的时候，调用这个方法进入图片选择页面
 */
- (void)addImage {
    
    [self addImgIBAction];
}

/**
 存草稿进入展示图片

 @param images images
 */
- (void)showNumPics:(NSArray *)images {

    for (UIImage *image in images) {
        MTAddImgModel *model = [[MTAddImgModel alloc] init];
        model.image = image;
        [self.dataSource addObject:model];
    }
    [self resetAddImgFrame];
    [self.collectionView reloadData];
}

- (void)openBtnClick{


    if ([NSStringFromClass([_viewController class]) isEqualToString:@"MTSendDynamicViewController"]) {
        [MTStatistics insterToDBWithPageAndButtonNumber:@"B0005P1403"];
    }

}

- (void)firstBtnClick {
    if ([NSStringFromClass([_viewController class]) isEqualToString:@"MTFeedbackController"]) {
        [MTStatistics insterToDBWithPageAndButtonNumber:@"B0004P1516"];
    }

    if ([NSStringFromClass([_viewController class]) isEqualToString:@"MTSendDynamicViewController"]) {
        [MTStatistics insterToDBWithPageAndButtonNumber:@"B0004P1403"];
    }

}


- (void)secondBtnClick {

    if ([NSStringFromClass([_viewController class]) isEqualToString:@"MTFeedbackController"]) {
        [MTStatistics insterToDBWithPageAndButtonNumber:@"B0005P1516"];
    }
    if ([NSStringFromClass([_viewController class]) isEqualToString:@"MTSendDynamicViewController"]) {
        [MTStatistics insterToDBWithPageAndButtonNumber:@"B0006P1403"];
    }

}

#pragma mark -   拍照回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak typeof(self) weakSelf = self;
    NSString *mediaType = info[UIImagePickerControllerMediaType];

    if([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *resultImage = nil;
        if(picker.allowsEditing){
            resultImage = info[UIImagePickerControllerEditedImage];
        } else {
            resultImage = info[UIImagePickerControllerOriginalImage];
        }
        MTAddImgModel *model = [[MTAddImgModel alloc] init];
        model.image = resultImage;
        [weakSelf.dataSource addObject:model];
        [self.collectionView reloadData];
        [self resetAddImgFrame];

    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
