//
//  ESSImageCategory.m
//
//  Created by Matthias Gansrigler on 1/24/11.
//  Copyright 2011 Eternal Storms Software. All rights reserved.
//

/*
 License Agreement for Source Code provided by Matthias Gansrigler
 
 This software is supplied to you by Matthias Gansrigler in consideration of your agreement to the following terms,
 and your use, installation, modification or redistribution of this software constitutes acceptance of these terms.
 If you do not agree with these terms, please do not use, install, modify or redistribute this software.
 
 In consideration of your agreement to abide by the following terms, and subject to these terms, Matthias Gansrigler grants you a personal,
 non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and
 disclaimers in all such redistributions of the software, and that in all cases attribution of Matthias Gansrigler as the original author of the source code
 shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Matthias Gansrigler may be used
 to endorse or promote products derived from the software without specific prior written permission from Matthias Gansrigler.
 Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Matthias Gansrigler herein,
 including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.
 
 The software is provided by Matthias Gansrigler on an "AS IS" basis.
 MATTHIAS GANSRIGLER MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT,
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL MATTHIAS GANSRIGLER BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT,
 TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Matthias Gansrigler HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ESSImageCategory.h"

@implementation NSImage (ESSImageCategory)

- (NSData *)representationForFileType:(NSBitmapImageFileType)fileType  withCompression:(CGFloat)comprFactor
{
	NSData *temp = nil;
	@try {
		temp = [self TIFFRepresentation];
	}
	@catch (NSException * e) {
		temp = [self TIFFRepresentationUsingCompression:NSTIFFCompressionLZW factor:comprFactor];
	}
	@finally {
		if (temp == nil)
			return nil;
		
		NSBitmapImageRep *bitmap = [NSBitmapImageRep imageRepWithData:temp];
		NSData *imgData = [bitmap representationUsingType:fileType properties:[NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:comprFactor] forKey:NSImageCompressionFactor]];
		return imgData;
	}
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
