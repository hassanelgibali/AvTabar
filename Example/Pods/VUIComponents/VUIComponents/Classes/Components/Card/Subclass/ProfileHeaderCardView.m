//
//  ProfileHeaderCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ProfileHeaderCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

#import "AnaVodafoneAlertController.h"
//#import "AppUser.h"
#import "RSKImageCropper.h"
//#import "BaseViewController.h"
#import "AnaVodafoneLabel.h"
@interface ProfileHeaderCardView()<UIImagePickerControllerDelegate,RSKImageCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *navTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgWidthConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *avatarIamgeView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *avatarImageButton;

@end

@implementation ProfileHeaderCardView

#pragma mark setter

-(void)awakeFromNib{
    
    [super awakeFromNib];
}

#pragma mark setter

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    _navTitleLabel.txt = title;
    
    //[self initialize];
}


-(void)setName:(NSString *)name{
    
    _name = name;
    
    _nameLabel.text = name;
    
    //[self initialize];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 70;

    NSDictionary* attributes;

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:28],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};

    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_navTitleLabel.text] attributes:attributes];

    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];

    CGFloat width = self.frame.size.width - 70;

    CGSize size = CGSizeMake(width, CGFLOAT_MAX);

    CGRect rect = [_navTitleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];

    attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:18]};

    contentViewHeight += rect.size.height;
    rect = [_nameLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];

    contentViewHeight += 155 + rect.size.height;

    UIBezierPath* path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, contentViewHeight-18)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width/2-18,  contentViewHeight-18)];

    [path addLineToPoint:CGPointMake(self.bounds.size.width/2,  contentViewHeight)];

    [path addLineToPoint:CGPointMake(self.bounds.size.width/2+18,  contentViewHeight-18)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width , contentViewHeight-18)];

    [path addLineToPoint:CGPointMake(self.bounds.size.width , 0)];

    [path addLineToPoint:CGPointMake(0, 0)];

    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.bounds;
    mask.path = path.CGPath;
    self.layer.mask = mask;
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
        
//        if ([[AppUser sharedInstance] isAvatarDataSet] ) {
//            [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"Delete Photo"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                //Implementation
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    _avatarIamgeView.image = [UIImage imageNamed:@"default_profilePhoto"];
//                });
//                
//                [self adjustProfilePhoto];
//            }]];
//        }
        
        [alertController addAction:[UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:nil]];
        
        [_controller presentViewController:alertController animated:YES completion:nil];
    }
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
        return YES;

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = source;
    
    [_controller presentViewController:picker animated:YES completion:NULL];
}

-(void)setBGImage:(UIImage *)BGImage{
    
    _BGImage = BGImage;
    
    _BGImageView.image = BGImage;
}

-(void)setPhoneNumber:(NSString*)phoneNumber{
    
    _phoneNumber = phoneNumber;
    
    _phoneNumberLabel.text = phoneNumber;
}

-(void)setAvatarImg:(UIImage *)avatarImg{
    
    _avatarImg = avatarImg;
    
    _avatarIamgeView.image = avatarImg;
}

#pragma mark init

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ProfileHeaderCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"morning_sl"]];
    
    _avatarIamgeView.layer.cornerRadius = _avatarIamgeView.frame.size.height/2;
    _avatarIamgeView.layer.borderWidth = 1;
    _avatarIamgeView.layer.borderColor = [UIColor grayColor].CGColor;
    _avatarIamgeView.layer.masksToBounds = YES;
    _editAvatarImg = false;
    
    _avatarIamgeView.userInteractionEnabled = true;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editProfileImageTapped:)];
    
    [_avatarIamgeView addGestureRecognizer:tap];

    [self addSubview:view];
}

@end
