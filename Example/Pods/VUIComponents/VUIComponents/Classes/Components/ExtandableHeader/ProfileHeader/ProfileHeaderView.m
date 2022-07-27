//
//  ProfileHeaderView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ProfileHeaderView.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "AnaVodafoneAlertController.h"
#import <VUIComponents/Utilities.h>
//#import "AppUser.h"
#import "RSKImageCropper.h"
//#import "BaseViewController.h"

@interface ProfileHeaderView()<UIImagePickerControllerDelegate,RSKImageCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *triangleView;
@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;
@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgWidthConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *avatarIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation ProfileHeaderView

#pragma mark setter

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.BGView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"morning_sl"]];
    
    _avatarIamgeView.layer.cornerRadius = _avatarIamgeView.frame.size.height/2;
    _avatarIamgeView.layer.borderWidth = 1;
    _avatarIamgeView.layer.borderColor = [UIColor grayColor].CGColor;
    _avatarIamgeView.layer.masksToBounds = YES;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.expansionMode = GSKStretchyHeaderViewContentAnchorTop;
}

#pragma mark setter

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    _navTitleLabel.text = title;

    [self adjustHeight];
}

-(void)setName:(NSString *)name{
   
    _name = name;
    
    _nameLabel.text = name;

    [self adjustHeight];
}

-(void)setBGImage:(UIImage *)BGImage{
    
    _BGImage = BGImage;
    
    _BGImageView.image = BGImage;
}

-(void)setPhoneNumber:(NSString*)phoneNumber{
    
    _phoneNumber = phoneNumber;

    _phoneNumberLabel.text = phoneNumber;

    [self adjustHeight];
}

-(void)adjustHeight{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:27],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_navTitleLabel] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_navTitleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    self.minimumContentHeight = 70 + rect.size.height;
    
    
    self.maximumContentHeight = self.minimumContentHeight;
    
    if (_nameLabel.text) {

    attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:20]};
    
     rect = [_nameLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    self.maximumContentHeight += rect.size.height ;
    }
    
    if (_phoneNumberLabel.text) {
        
        attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:16]};
    
        rect = [_phoneNumberLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    self.maximumContentHeight += rect.size.height + 172;
    }
}

-(void)setAvatarImg:(UIImage *)avatarImg{
    
    _avatarImg = avatarImg;
    
    _avatarIamgeView.image = avatarImg;
}

- (IBAction)editProfileImageTapped:(id)sender {
    
    if (_editAvatarImg) {
    
    AnaVodafoneAlertController *alertController = [AnaVodafoneAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"From Camera"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"From Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    
//    if ([[AppUser sharedInstance] isAvatarDataSet] ) {
//        [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"Delete Photo"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            //Implementation
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _avatarIamgeView.image = [UIImage imageNamed:@"default_profilePhoto"];
//            });
//            
//            [self adjustProfilePhoto];
//        }]];
//    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:nil]];
    
    [_controller presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) adjustProfilePhoto {
    
//    [_avatarIamgeView setImage:[[AppUser sharedInstance] avatarImage]];
}

#pragma mark - UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *originalImage = info[UIImagePickerControllerEditedImage];
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:originalImage];
        imageCropVC.delegate = weakSelf;
        [((UIViewController*)self->_controller).navigationController pushViewController:imageCropVC animated:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RSKImageCropViewController delegate methods

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    
    [((UIViewController*)_controller).navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
    
//    [[AppUser sharedInstance] setAvatarImage:croppedImage];
    
    _avatarIamgeView.image = croppedImage;
    
    [((UIViewController*)_controller).navigationController popViewControllerAnimated:YES];
}

- (void) showImagePickerWithSourceType:(UIImagePickerControllerSourceType)source {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = _controller;
    picker.allowsEditing = YES;
    picker.sourceType = source;
    
    [_controller presentViewController:picker animated:YES completion:NULL];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    
    CGFloat alpha = 1;
    CGFloat blurAlpha = 1;
    if (stretchFactor > 1) {
        alpha = CGFloatTranslateRange(stretchFactor, 1, 1.12, 1, 0);

        blurAlpha = alpha;
    }
    else if (stretchFactor <= 0.8) {

        alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    }
    else if (stretchFactor <= 1) {
        
        _avatarImgWidthConstraint.constant = 100 * MAX(alpha, 0.5);
        
        _avatarImgHeightConstraint.constant= 100* MAX(alpha, 0.5);
        
        _avatarIamgeView.layer.cornerRadius = _avatarImgHeightConstraint.constant/2;
        
    }


    alpha = MAX(1, alpha);
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_triangleView) {
        UIBezierPath* path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width/2, _triangleView.bounds.size.height)];
        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width, 0)];
        [path addLineToPoint:CGPointMake(0, 0)];
        
        CAShapeLayer *mask = [CAShapeLayer new];
        mask.frame = _triangleView.bounds;
        mask.path = path.CGPath;
        _triangleView.layer.mask = mask;
    }
}


#pragma mark init
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self = [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
//        self = [self commonInit];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
       self = [self commonInit];
    }
    return self;
}

-(ProfileHeaderView *)commonInit{
    
    ProfileHeaderView *headerView;
    
    NSArray* nibViews = [[Utilities getPodBundle] loadNibNamed:@"ProfileHeaderView"
                                                      owner:self
                                                    options:nil];
    headerView = nibViews.firstObject;
    
    _editAvatarImg = false;
    return headerView;
}


@end
