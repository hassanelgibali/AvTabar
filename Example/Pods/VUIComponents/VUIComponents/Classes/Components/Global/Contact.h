//
//  Contact.h
//  Engzely
//
//  Created by Shady Ghalab on 12/8/13.
//  Copyright (c) 2013 Shady Ghalab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Contact : NSObject

@property(nonatomic , strong)NSString *firstname;
@property(nonatomic , strong)NSString *lastname;

//@property(nonatomic , strong)NSString *nickName;
//@property(nonatomic , strong)NSString *middleName;
//@property(nonatomic , strong)NSString *email;

@property(nonatomic , strong)NSString *phone;
@property(nonatomic , strong)NSString *homeNumber;
@property(nonatomic , strong)NSString *worknumber;
@property(nonatomic , strong)UIImage *image;

@end
