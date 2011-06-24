//
//  ESSImageCategory.m
//
//  Created by Matthias Gansrigler on 1/24/11.
//  Copyright 2011 Eternal Storms Software. All rights reserved.
//

#import "ESSImageCategory.h"

@implementation NSImage (ESSImageCategory)

- (NSData *)representationForFileType: (NSBitmapImageFileType) fileType  withCompression:(CGFloat)comprFactor
{
	NSData *temp = [self TIFFRepresentation];
	NSBitmapImageRep *bitmap = [NSBitmapImageRep imageRepWithData:temp];
	NSData *imgData = [bitmap representationUsingType:fileType properties:[NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:comprFactor]
																									  forKey:NSImageCompressionFactor]];
	return imgData;
}

- (NSData *)JPEGRepresentationWithCompression:(CGFloat)comprRate
{
	return [self representationForFileType: NSJPEGFileType withCompression:comprRate];
}

- (NSData *)PNGRepresentation
{
	return [self representationForFileType: NSPNGFileType withCompression:1.0];
}

- (NSData *)JPEG2000RepresentationWithCompression:(CGFloat)comprRate
{
	return [self representationForFileType: NSJPEG2000FileType withCompression:comprRate];	
}

- (NSData *)GIFRepresentation
{
	return [self representationForFileType: NSGIFFileType withCompression:1.0];	
}

- (NSData *)BMPRepresentation
{
	return [self representationForFileType: NSBMPFileType withCompression:1.0];		
}

- (NSData *)dataForPboardType:(NSString *)pboardtype
{
	NSPasteboard *pboard = nil;
	pboard = [NSPasteboard pasteboardWithName:@"essimagecategory"];
	[pboard declareTypes:[NSArray arrayWithObject:NSTIFFPboardType] owner:nil];
	[pboard setData:[self TIFFRepresentation] forType:NSTIFFPboardType];
	[pboard types];
	NSData *data = [pboard dataForType:pboardtype];
	[pboard releaseGlobally];
	return data;
}

- (NSData *)PDFRepresentation
{
	return [self dataForPboardType:NSPDFPboardType];
}

@end
