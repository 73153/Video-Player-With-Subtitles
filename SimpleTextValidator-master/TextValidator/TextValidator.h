//
//  TextValidator.h
//  TextValidator
//
//  Created by Eddie on 2/16/13.
//  Copyright (c) 2013 eddieios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextValidator : NSObject

+ (BOOL)isValidEmail:(NSString *)text;
+ (BOOL)isValidPhone:(NSString *)text;
+ (BOOL)isValidTwoLetterStateAbbreviation:(NSString *)text;
+ (BOOL)isValidStateName:(NSString *)text;
+ (BOOL)isValidZipcode:(NSString *)text;
+ (BOOL)isValidName:(NSString *)text;

+ (NSString *)formatPhoneNumber:(NSString *)text format:(NSString *)format error:(NSError**)error;


@end
