//
//  ColorsFontDefine.h
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#ifndef ColorsFontDefine_h
#define ColorsFontDefine_h


#pragma mark - 颜色





#pragma mark 颜色转换

#define HexColor(str) [UIColor colorWithHexString:str]

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//获取RGB颜色
#define ColorA(str1,str2,str3,str4) [UIColor colorWithRed:str1/255.0 green:str2/255.0 blue:str3/255.0 alpha:str4]
#define Color(str1,str2,str3) ColorA(str1,str2,str3,1.0f)
//随机颜色
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))






#pragma mark - 字体
/*font
 Font18: 标准字36px18sp/18pt导航标题、文章标题、重要突出词句
 Font16: 标准字32px16sp/16pt用户姓名、列表文章标题、分类栏目、模块名称、按钮文字等
 Font14: 标准字28px14sp/14pt长段描述文字、非标题文字、文章正文、提示性文字等
 Font12: 标准字24px12sp/12pt次要描述文字、小副标题、 次要提示、标签文字等
 Font10: 标准字20px10sp/10pt标签栏名称、次要长段描述或提示文字
 */

#define Font(F)             [UIFont systemFontOfSize:(F)]
#define FontBold(F)         [UIFont boldSystemFontOfSize:(F)]
#define Font20              [UIFont fontWithName:@"Helvetica" size:20]
#define Font20Bold          [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define Font19              [UIFont fontWithName:@"Helvetica" size:19]
#define Font19Bold          [UIFont fontWithName:@"Helvetica-Bold" size:19]
#define Font18              [UIFont fontWithName:@"Helvetica" size:18]
#define Font18Bold          [UIFont fontWithName:@"Helvetica-Bold" size:18]
#define Font17              [UIFont fontWithName:@"Helvetica" size:17]
#define Font17Bold          [UIFont fontWithName:@"Helvetica-Bold" size:17]
#define Font16              [UIFont fontWithName:@"Helvetica" size:16]
#define Font16Bold          [UIFont fontWithName:@"Helvetica-Bold" size:16]
#define Font15              [UIFont fontWithName:@"Helvetica" size:15]
#define Font15Bold          [UIFont fontWithName:@"Helvetica-Bold" size:15]
#define Font14              [UIFont fontWithName:@"Helvetica" size:14]
#define Font14Bold          [UIFont fontWithName:@"Helvetica-Bold" size:14]
#define Font13              [UIFont fontWithName:@"Helvetica" size:13]
#define Font13Bold          [UIFont fontWithName:@"Helvetica-Bold" size:13]
#define Font12              [UIFont fontWithName:@"Helvetica" size:12]
#define Font12Bold          [UIFont fontWithName:@"Helvetica-Bold" size:12]
#define Font10              [UIFont fontWithName:@"Helvetica" size:10]
#define Font10Bold          [UIFont fontWithName:@"Helvetica-Bold" size:10]
#define FontTitleNormal     [UIFont fontWithName:@"Helvetica-Bold" size:15]
#define FontPromptNormal    [UIFont fontWithName:@"Helvetica" size:14]

#define BOLDSYSTEMFONT(FONTSIZE)        [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)            [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)             [UIFont fontWithName:(NAME)size:(FONTSIZE)]






#endif /* ColorsFontDefine_h */
