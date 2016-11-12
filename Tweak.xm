//Project RoundedSwitchr a tweak that rounds the switcher
//Created by iKilledAppl3 on October 28, 2016
//Originally thought about in August of 2016 :P
//Respring from homescreen card view code was borrowed from EasyRespring thanks :)
//UICache codes are commented out for now :P

#import <UIKit/UIKit.h>

//prefs
#define plist @"/var/mobile/Library/Preferences/com.ikilledappl3.roundswitchr.plist"

static BOOL isEnabled;
static int kOptionEnabled2;
static int kRespringEnabled = 0;
static BOOL kOptionEnabled;
static int kRebootEnabled = 1;
static int kSafeModeEnabled = 2;
/*static int kUICacheEnabled = 3;*/
static CGFloat radiusSlider;

static void respringDevice() {
	system ("killall -9 backboardd");
}

static void rebootDevice() {
	system ("reboot");
}

/*static void clearCache() {
	system ("uicache");
}
*/
static void safeMode() {
	system ("killall -SEGV SpringBoard");
}

typedef void* CDUnknownBlockType;

@interface SBDisplayItem : NSObject
@property(readonly, assign, nonatomic) NSString* displayIdentifier;
@end

@interface SBAppSwitcherSoftOutlineShadowView : UIView {
	UIImageView* _shadowImageView;

}
@end

%hook SBAppSwitcherSoftOutlineShadowView
	
-(void)layoutSubviews {
	if (isEnabled == YES) {
		
		%orig; 
		UIImageView *shadowImage =  MSHookIvar<UIImageView *>(self, "_shadowImageView");
		shadowImage.hidden = YES;
		shadowImage.alpha = 0;
	}
	
	else {
		%orig;
	}
}
%end

%hook SBSwitcherMetahostingHomePageContentView
-(void)setCornerRadius:(double)arg1 {
	if (isEnabled == YES) {
		
		%orig(radiusSlider);
	}
	
	else {
		%orig(arg1);
	}
}
-(double) cornerRadius {
	if (isEnabled == YES) {
		return radiusSlider;
	}
	
	else {
		return %orig;
	}
}
%end
%hook SBAppSwitcherHomePageCellView
-(void)setCornerRadius:(double)arg1 {
	if (isEnabled == YES) {
		
		%orig(radiusSlider);
	}
	
	else {
		%orig(arg1);
	}
}
-(double) cornerRadius {
	if (isEnabled == YES) {
		return radiusSlider;
	}
	
	else {
		return %orig;
	}
}
%end

%hook SBSwitcherAppViewWrapperPageContentView
-(void) setCornerRadius:(double)arg1 {
	if (isEnabled == YES) {
		
		%orig(radiusSlider);
	}
	
	else {
		%orig(arg1);
	}
}
-(double) cornerRadius {
	if (isEnabled == YES)  {
		return radiusSlider;
	}
	
	else {
		return %orig;
	}
}
%end

%hook SBAppSwitcherSnapshotView
-(void) setCornerRadius:(double)arg1 {
	if (isEnabled == YES) {
		
		%orig(radiusSlider);
	}
	
	else {
		%orig(arg1);
	}
}
-(double) cornerRadius {
	if (isEnabled == YES) {
		return radiusSlider;
	}
	
	else {
		return %orig;
	}
}
%end

%hook SBUIDismissSwitcherController
-(id)initWithTransitionContextProvider:(id)arg1:(id)arg2:(BOOL)arg3 {
		if (isEnabled == YES) {
			return nil;
			return nil;
			return nil;
			return FALSE;
	}
	
	else {
		return %orig;
	}
}
%end

%hook SBDeckSwitcherViewController
- (_Bool)isDisplayItemOfContainerRemovable:(id)arg1 {
	if (kRespringEnabled == 0 && kOptionEnabled == YES && kOptionEnabled2 == 0) {
		return TRUE;
	}
	
	else if (kRebootEnabled == 1 && kOptionEnabled == YES && kOptionEnabled2 == 1) {
		return TRUE;
	}
	
	else if (kSafeModeEnabled == 2 && kOptionEnabled == YES && kOptionEnabled2 == 2) {
		return TRUE;
	} 
	
	/*else if (kUICacheEnabled == 3 && kOptionEnabled == YES && kOptionEnabled2 == 3) {
		return TRUE;
	} 
	*/
	
	else {
		return %orig;
	}
}
- (void)removeDisplayItem:(SBDisplayItem *)arg1 updateScrollPosition:(_Bool)arg2 forReason:(long long)arg3 completion:(CDUnknownBlockType)arg4 {
    if ([arg1.displayIdentifier isEqualToString:@"com.apple.springboard"] && kRespringEnabled == 0 && kOptionEnabled == YES && kOptionEnabled2 == 0) {
	respringDevice();
	}
	
	else if ([arg1.displayIdentifier isEqualToString:@"com.apple.springboard"] && kRebootEnabled == 1  && kOptionEnabled == YES && kOptionEnabled2 == 1) {
		rebootDevice();	
    	}
		
		else if ([arg1.displayIdentifier isEqualToString:@"com.apple.springboard"] && kSafeModeEnabled == 2 && kOptionEnabled == YES && kOptionEnabled2 == 2) {
			safeMode();	
		}	
		
		/*else if ([arg1.displayIdentifier isEqualToString:@"com.apple.springboard"] && kUICacheEnabled == 3 && kOptionEnabled == YES && kOptionEnabled2 == 3) {
			clearCache();	
			}*/
    else  {
        %orig;
    }
}
%end

static void loadPrefs()
{	
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:plist];
    if(prefs)
    {	
		isEnabled = ( [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : isEnabled );
		kOptionEnabled2 = ( [prefs objectForKey:@"kOptionEnabled2"] ? [[prefs objectForKey:@"kOptionEnabled2"] intValue] : kOptionEnabled2);
		kRespringEnabled = ( [prefs objectForKey:@"0"] ? [[prefs objectForKey:@"0"] intValue] : kRespringEnabled );
		kOptionEnabled = ( [prefs objectForKey:@"kOptionEnabled"] ? [[prefs objectForKey:@"kOptionEnabled"] boolValue] : kOptionEnabled );
		kRebootEnabled = ( [prefs objectForKey:@"1"] ? [[prefs objectForKey:@"1"] intValue] : kRebootEnabled );
		kSafeModeEnabled = ( [prefs objectForKey:@"2"] ? [[prefs objectForKey:@"2"] intValue] : kSafeModeEnabled);
		/*kUICacheEnabled = ( [prefs objectForKey:@"3"] ? [[prefs objectForKey:@"3"] intValue] : kUICacheEnabled);*/
		radiusSlider = ( [prefs objectForKey:@"radius"] ? [[prefs objectForKey:@"radius"] floatValue] : radiusSlider);
	 }
}

%ctor 
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ikilledappl3.roundswitchr-prefsreload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		    loadPrefs();
		}