//
//  TextValidator.m
//  TextValidator
//
//  Created by Eddie on 2/16/13.
//  Copyright (c) 2013 eddieios. All rights reserved.
//

#import "TextValidator.h"

@implementation TextValidator

+ (BOOL)isValidEmail:(NSString *)text {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];

}

+ (BOOL)isValidPhone:(NSString *)text {

    NSString *regex = @"^[+]?\\s?[1]?\\s?[(]?[0-9]{3}[)]?[.\\- ]{0,2}[0-9]{3}[.\\- ]?[0-9]{4}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

+ (BOOL)isValidTwoLetterStateAbbreviation:(NSString *)text {
    NSString *regex = @"^(AA|AE|AP|AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

+ (BOOL)isValidStateName:(NSString *)text {
    
    NSString *regex = @"^(Alabama|Alaska|Arizona|Arkansas|California|Colorado|Connecticut|Delaware|District of Columbia|Florida|Georgia|Hawaii|Idaho|Illinois|Indiana|Iowa|Kansas|Kentucky|Louisiana|Maine|Maryland|Massachusetts|Michigan|Minnesota|Mississippi|Missouri|Montana|Nebraska|Nevada|New Hampshire|New Jersey|New Mexico|New York|North Carolina|North Dakota|Ohio|Oklahoma|Oregon|Pennsylvania|Rhode Island|South Carolina|South Dakota|Tennessee|Texas|Utah|Vermont|Virginia|Washington|West Virginia|Wisconsin|Wyoming)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];

}

+ (BOOL)isValidZipcode:(NSString *)text {
    NSString *regex = @"^\\d{5}(-\\d{4})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

+ (BOOL)isValidName:(NSString *)text {
    NSString *regex = @"^[a-zA-Z\\s]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

+ (NSString *)formatPhoneNumber:(NSString *)text format:(NSString *)format error:(NSError**)error {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[#]{1}"
                                                                           options:NSRegularExpressionCaseInsensitive error:error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:format options:0 range:NSMakeRange(0, format.length)];
    
    if (numberOfMatches != 10) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Format does not have 10 digit representations (i.e., \"#\")" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"eddieios" code:100 userInfo:errorDetail];
        return @"";
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{1}" options:0 error:error];    
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    NSMutableArray *numArray = [NSMutableArray arrayWithObjects:
                                @"", @"", @"", @"", @"", @"", @"", @"", @"", @"",nil];
    
    for (int i = 0; i < matches.count; i++) {
        NSTextCheckingResult *match = [matches objectAtIndex:i];
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        [numArray insertObject:matchString atIndex:i];
    }
    
    NSString *modifiedFormat = [format stringByReplacingOccurrencesOfString:@"#" withString:@"%@"];
    NSString *formattedString = [NSString stringWithFormat:modifiedFormat,
                                 [numArray objectAtIndex:0],
                                 [numArray objectAtIndex:1],
                                 [numArray objectAtIndex:2],
                                 [numArray objectAtIndex:3],
                                 [numArray objectAtIndex:4],
                                 [numArray objectAtIndex:5],
                                 [numArray objectAtIndex:6],
                                 [numArray objectAtIndex:7],
                                 [numArray objectAtIndex:8],
                                 [numArray objectAtIndex:9]];
    return formattedString;
}




@end
