#import "IdentifierValidator.h"

int getIndex (char ch);
BOOL isNumber (char ch);

int getIndex (char ch) {
    if ((ch >= '0'&& ch <= '9')||(ch >= 'a'&& ch <= 'z')||
        (ch >= 'A' && ch <= 'Z')|| ch == '_') {
        return 0;
    }
    if (ch == '@') {
        return 1;
    }
    if (ch == '.') {
        return 2;
    }
    return -1;
}

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}


@implementation IdentifierValidator

+ (BOOL) isValidZipcode:(NSString*)value 
{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++) 
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9')) 
        {
            return FALSE;
        }
    }
    return TRUE;
}

+ (BOOL) validateEmail:(NSString *)candidate
{
    NSArray *array = [candidate componentsSeparatedByString:@"."];
    if ([array count] >= 4) {
        return FALSE;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL) isValidEmail:(NSString*)value {
    static int state[5][3] = {
        {1, -1, -1},
        {1,  2, -1},
        {3, -1, -1},
        {3, -1, 4},
        {4, -1, -1}
    };
    BOOL valid = TRUE;
    const char *cvalue = [value UTF8String];
    int currentState = 0;
    int len = strlen(cvalue);
    int index;
    for (int i = 0; i < len && valid; i++) {
        index = getIndex(cvalue[i]);
        if (index < 0) {
            valid = FALSE;
        }
        else {
            currentState = state[currentState][index];
            if (currentState < 0) {
                valid = FALSE;
            }
        }
    }
    //end state is invalid
    if (currentState != 4) {
        valid = FALSE;
    }
    return valid;
}

+ (BOOL) isValidNumber:(NSString*)value{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return FALSE;
        }
    }
    return TRUE;
}

+ (BOOL) isValidPhone:(NSString*)value {
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 11) {
        return FALSE;
    }
    if (![IdentifierValidator isValidNumber:value]) 
    {
        return FALSE;
    }
    NSString *preString = [[NSString stringWithFormat:@"%@",value] substringToIndex:2];    
    if ([preString isEqualToString:@"13"] ||
        [preString isEqualToString: @"15"] || 
        [preString isEqualToString: @"18"]) 
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    return TRUE;
}
+ (BOOL) isValidString:(NSString*)value 
{
    return value && [value length];
}
const int factor[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };//加权因子 
const int checktable[] = { 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 };//校验值对应表
+ (BOOL) isValidIdentifier:(NSString*)value 
{
    const int LENGTH = 18;    
    const char *str = [[value lowercaseString] UTF8String];
    NSInteger i;    
    NSInteger length = strlen(str);
    BOOL result = TRUE;    
   
    if (15 != length && LENGTH != length)
    {
        result = FALSE;
    }
    else
    {
        for (i = 1; i < length - 1; i++)
        {
            if(!(str[i] >= '0' && str[i] <= '9')) 
            {
                result = FALSE;
                break;
            }
        }
        if (result) 
        {
            if(LENGTH == length)
            {
                if (!((str[i] >= '0' && str[i] <= '9')||str[i] == 'X'||str[i] == 'x'))
                {
                    result = FALSE;
                }
            }
        }
       
        if (result && length == LENGTH) 
        {
            int i;
            int *ids = malloc(sizeof(int)*LENGTH);
            for (i = 0; i < LENGTH; i++) 
            {
                ids[i] = str[i] - 48;             
            }
            int checksum = 0; 
            for (i = 0; i < LENGTH - 1; i ++ )
            {
                checksum += ids[i] * factor[i];
            }
            if (ids[17] == checktable[checksum]|| 
                (str[17] == 'x' && checktable[checksum % 11] == 10))  
            {
                result  = TRUE;
            }
            else 
            {
                result  = FALSE;            
            }
            free(ids);
            ids = NULL;
        }        
    }
    return result;
}
+ (BOOL) isValidPassport:(NSString*)value 
{
    const char *str = [value UTF8String];
    char first = str[0];
    NSInteger length = strlen(str);
    if (!(first == 'P' || first == 'G')) 
    {
        return FALSE;
    }
    if (first == 'P')
    {
        if (length != 8) 
        {
            return FALSE;
        }
    }
    if (first == 'G') 
    {
        if (length != 9) 
        {
            return FALSE;
        }
    }
    BOOL result = TRUE;
    for (NSInteger i = 1; i < length; i++) 
    {
        if (!(str[i] >= '0' && str[i] <= '9')) 
        {
            result = FALSE;
            break;
        }
    }        
    return result;
}

+ (BOOL) isValidCreditNumber:(NSString*)value
{
    BOOL result = TRUE;
    NSInteger length = [value length];    
    if (length >= 13) 
    {
        result = [IdentifierValidator isValidNumber:value];    
        if (result) 
        {
            NSInteger twoDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 2)] integerValue];
            NSInteger threeDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 3)] integerValue];       
            NSInteger fourDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 4)] integerValue];        
            //Diner's Club
            if (((threeDigitBeginValue >= 300 && threeDigitBeginValue <= 305)||
                 fourDigitBeginValue == 3095||twoDigitBeginValue==36||twoDigitBeginValue==38) && (14 != length)) 
            {
                result = FALSE;
            }
            //VISA
            else if([value hasPrefix:@"4"] && !(13 == length||16 == length))
            {
                result = FALSE;
            }
            //MasterCard
            else if((twoDigitBeginValue >= 51||twoDigitBeginValue <= 55) && (16 != length))
            {
                result = FALSE;
            }        
            //American Express
            else if(([value hasPrefix:@"34"]||[value hasPrefix:@"37"]) && (15 != length))
            {
                result = FALSE;
            }  
            //Discover
            else if([value hasPrefix:@"6011"] && (16 != length))
            {
                result = FALSE;
            }          
            else 
            {
                NSInteger begin = [[value substringWithRange:NSMakeRange(0, 6)] integerValue];
                //CUP
                if ((begin >= 622126 && begin <= 622925) && (16 != length))
                {
                    result = FALSE;                
                }
                //other
                else 
                {
                    result = TRUE;
                }
            }
        }
        if (result) 
        {
            NSInteger digitValue;
            NSInteger checkSum = 0;
            NSInteger index = 0; 
            NSInteger leftIndex;
            //even length, odd index 
            if (0 == length%2) 
            {
                index = 0;
                leftIndex = 1;
            }
            //odd length, even index         
            else 
            {
                index = 1;  
                leftIndex = 0;
            }
            while (index < length) 
            {
                digitValue = [[value substringWithRange:NSMakeRange(index, 1)] integerValue];            
                digitValue = digitValue*2;
                if (digitValue >= 10) 
                {
                    checkSum += digitValue/10 + digitValue;
                }
                else
                {
                    checkSum += digitValue;
                }
                digitValue = [[value substringWithRange:NSMakeRange(leftIndex, 1)] integerValue];                        
                checkSum += digitValue;    
                index += 2;
                leftIndex += 2;            
            }
            result = (0 == checkSum) ? TRUE:FALSE;
        }        
    }
    else
    {
        result = FALSE;
    }
    return result;
}
+ (BOOL) isValidBirthday:(NSString*)birthday
{
    BOOL result = FALSE;
    if (birthday && 8 == [birthday length]) 
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [formatter dateFromString:birthday];
        if (date)
        {
            result = TRUE;
        }
    }
    return result;
}
+ (BOOL) isChinaUnicomPhoneNumber:(NSString*) phonenumber
{
   
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
   
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//   
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//   
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//   
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    NSString * PHS1 = @"^0(10|2[0-5789]|\\d{3}-)\\d{7,8}$";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    NSPredicate *regextestphs1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
    
    if (//([regextestmobile evaluateWithObject:phonenumber] == YES)|| 
//        ([regextestcm evaluateWithObject:phonenumber] == YES)||
//        ([regextestct evaluateWithObject:phonenumber] == YES)||
          ([regextestcu evaluateWithObject:phonenumber] == YES)
//        || ([regextestphs evaluateWithObject:phonenumber] == YES)
//        || ([regextestphs1 evaluateWithObject:phonenumber] == YES)
        )
    {
        return YES;
    }
    else 
    {
        return NO;
    }
}
//+ (BOOL) isChinaUnicomPhoneNumber:(NSString*) phoneNumber
//{
//    BOOL unicom = TRUE;
//    NSString *mobileNumFormat13 = @"[1]{1}[3]{1}[4-9]{1}[0-9]{8}";
//    NSString *mobileNumFormat14 = @"[1]{1}[4]{1}[7]{1}[0-9]{8}";
//    NSString *mobileNumFormat15 = @"[1]{1}[5]{1}[012789]{1}[0-9]{8}";
//    NSString *mobileNumFormat18 = @"[1]{1}[8]{1}[2378]{1}[0-9]{8}";
//    NSPredicate *predicate13 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileNumFormat13];
//    NSPredicate *predicate14 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileNumFormat14];
//    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileNumFormat15];
//    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileNumFormat18];
//    if ([predicate13 evaluateWithObject:phoneNumber] ||
//        [predicate14 evaluateWithObject:phoneNumber] ||
//        [predicate15 evaluateWithObject:phoneNumber] ||
//        [predicate18 evaluateWithObject:phoneNumber]) 
//    {
//        unicom = FALSE;
//    }
//    return unicom;
//}
+ (BOOL) isValid:(IdentifierType) type value:(NSString*) value 
{
    if (!value ||[[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {        
        return FALSE;
    }
    BOOL result = TRUE;
    switch (type) 
    {
        case IdentifierTypeZipCode:
            result = [IdentifierValidator isValidZipcode:value];
            break;
        case IdentifierTypeEmail:
//            result = [IdentifierValidator isValidEmail:value];
            result = [IdentifierValidator validateEmail:value];
            break;
        case IdentifierTypePhone:
            result = [IdentifierValidator isValidPhone:value];
            break;
        case IdentifierTypeUnicomPhone:
            result = [IdentifierValidator isChinaUnicomPhoneNumber:value];
            break;
        case IdentifierTypeQQ:
            result = [IdentifierValidator isValidNumber:value];
            break;
        case IdentifierTypeNumber:
            result = [IdentifierValidator isValidNumber:value];
            break;           
        case IdentifierTypeString:
            result = [IdentifierValidator isValidString:value];
            break;
        case IdentifierTypeIdentifier:
            result = [IdentifierValidator isValidIdentifier:value];            
            break;
        case IdentifierTypePassort:
            result = [IdentifierValidator isValidPassport:value];            
            break;            
        case IdentifierTypeCreditNumber:
            result = [IdentifierValidator isValidCreditNumber:value];
            break;
        case IdentifierTypeBirthday:
            result = [IdentifierValidator isValidBirthday:value];            
            break;
        default:
            break;
    }
    return result;
}

@end