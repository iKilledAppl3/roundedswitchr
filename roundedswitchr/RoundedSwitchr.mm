#import <CepheiPrefs/HBListController.h>
#import <CepheiPrefs/HBTintedTableCell.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBTwitterCell.h>
#import <CepheiPrefs/HBImageTableCell.h>
#import <CepheiPrefs/HBPackageNameHeaderCell.h>

@interface RoundedSwitchrListController: HBListController {
}
@end

@implementation RoundedSwitchrListController

+ (NSString *)hb_specifierPlist {
	return @"RoundedSwitchr";
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0];
}

-(void)loadView {
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(shareTapped)];
}
- (void)shareTapped {
    NSString *text = [NSString stringWithFormat:@"I am reshaping my multitasking cards with #RoundedSwitchr by @iKilledAppl3! Download in Cydia for FREE!"];
    
    if ([UIActivityViewController alloc]) {
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
        [(UINavigationController *)[super navigationController] presentViewController:activityViewController animated:YES completion:NULL];
    }else {
        //awesomeness
    }
}

-(void)respring {
    system ("killall -9 backboardd");
}

-(void)openSoundTaskerTweak {
    
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.ikilledappl3.soundtasker"]];
       
}

-(void)openSleekSwitcherTweak {
    
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cydiageek.sleekswitcher"]];
       
}

-(void)donate { 
 
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://is.gd/donate2ToxicAppl3Inc"]];
}
 
@end

// vim:ft=objc