//
//  ESSImageCategory.h
//
//  Created by Matthias Gansrigler on 1/24/11.
//  Copyright 2011 Eternal Storms Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface NSImage (ESSImageCategory)
- (NSData *)dataForPboardType:(NSString *)pboardtype;
- (NSData* )representationForFileType: (NSBitmapImageFileType) fileType withCompression:(CGFloat)comprFactor;
- (NSData *)JPEGRepresentationWithCompression:(CGFloat)comprRate;
- (NSData *)JPEG2000RepresentationWithCompression:(CGFloat)comprRate;
- (NSData *)PNGRepresentation;
- (NSData *)GIFRepresentation;
- (NSData *)BMPRepresentation;
- (NSData *)PDFRepresentation;
@end
