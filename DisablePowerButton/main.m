//
//  main.m
//  DisablePowerButton
//
//  Created by Asger Hautop Drewsen on 16/04/2013.
//  Copyright (c) 2013 Tyilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

static CGEventRef callback(CGEventTapProxy proxy, CGEventType type, CGEventRef cgEvent, void *refcon) {
	if(type == NSSystemDefined) {
		NSEvent *event = [NSEvent eventWithCGEvent:cgEvent];
		
		if(event.subtype == 1) { // Power button event
			return NULL;
		}
	}
	
	return cgEvent;
}

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		CFMachPortRef eventTap = CGEventTapCreate(0, 0, kCGEventTapOptionDefault, NSSystemDefinedMask, callback, NULL);
		
		CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
		CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
		
		CFRunLoopRun();
	}
    return 0;
}

