//
//  AppDelegate.h
//  cDock GUI
//
//  Created by Wolfgang Baird on 09.09.2015.
//  Copyright © 2015 Wolfgang Baird. All rights reserved.
//

@import Foundation;
@import AppKit;
#import "WAYAppStoreWindow.h"
#import "PFAboutWindowController.h"
#import "PFMoveApplication.h"

# define appSupport  [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject]
# define usrLibrary  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
# define themeName   [[NSMutableDictionary dictionaryWithContentsOfFile:plist_cDock] objectForKey:@"cd_theme"]
# define themeFldr   [appSupport stringByAppendingPathComponent:@"cDock/themes/"]
# define plist_Theme [appSupport stringByAppendingFormat:@"/cDock/themes/%@/%@.plist", themeName, themeName]
# define plist_cDock [usrLibrary stringByAppendingPathComponent:@"Preferences/org.w0lf.cDock.plist"]
# define plist_Dock  [usrLibrary stringByAppendingPathComponent:@"Preferences/com.apple.dock.plist"]

//# define plist_Theme []

@interface NSToolTipManager : NSObject
{
    double toolTipDelay;
}
+ (id)sharedToolTipManager;
- (void)setInitialToolTipDelay:(double)arg1;
@end

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Windows
@property PFAboutWindowController *aboutWindowController;
@property WAYAppStoreWindow *window;
@property (weak) IBOutlet NSPopover *poppy;

@property (weak) IBOutlet NSButton *pop_toggle;

@property (weak) IBOutlet NSButton *pop_info;
@property (weak) IBOutlet NSButton *pop_paypal;
@property (weak) IBOutlet NSButton *pop_email;
@property (weak) IBOutlet NSButton *pop_github;

// Views
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSView *themeView;
@property (weak) IBOutlet NSView *simblView;
@property (weak) IBOutlet NSView *rootlView;

// cDock preferences
@property (weak) IBOutlet NSButton *reset_Dock;
@property (weak) IBOutlet NSButton *disable_cDock;
@property (weak) IBOutlet NSButton *auto_checkUpdates;
@property (weak) IBOutlet NSButton *auto_installUpdates;
@property (weak) IBOutlet NSButton *cdock_isVibrant;

// cDock settings
@property (weak) IBOutlet NSButton *cd_fullWidth;
@property (weak) IBOutlet NSButton *cd_hideLabels;
@property (weak) IBOutlet NSButton *cd_iconReflection;
@property (weak) IBOutlet NSButton *cd_darkenMouseOver;
@property (weak) IBOutlet NSButton *cd_showFrost;
@property (weak) IBOutlet NSButton *cd_showGlass;
@property (weak) IBOutlet NSButton *cd_showSeparator;
@property (weak) IBOutlet NSSlider *cd_cornerRadius;
@property (weak) IBOutlet NSSlider *cd_borderSize;

@property (weak) IBOutlet NSPopUpButton *cd_darkMode;
@property (weak) IBOutlet NSPopUpButton *cd_theme;

// Color pickers
@property (weak) IBOutlet NSButton *dockBG;
@property (weak) IBOutlet NSColorWell *dockWELL;
@property (weak) IBOutlet NSButton *borderBG;
@property (weak) IBOutlet NSColorWell *borderWELL;
@property (weak) IBOutlet NSButton *labelBG;
@property (weak) IBOutlet NSColorWell *labelWELL;
@property (weak) IBOutlet NSButton *shadowBG;
@property (weak) IBOutlet NSColorWell *shadowWELL;
@property (weak) IBOutlet NSButton *separatorBG;
@property (weak) IBOutlet NSColorWell *separatorWELL;

// Indicators
@property (weak) IBOutlet NSButton *cd_customIndicator;
@property (weak) IBOutlet NSButton *cd_indicatorBG;
@property (weak) IBOutlet NSButton *cd_sizeIndicator;
@property (weak) IBOutlet NSSlider *cd_indicatorWidth;
@property (weak) IBOutlet NSSlider *cd_indicatorHeight;
@property (weak) IBOutlet NSColorWell *indicatorWELL;

// Image background
@property (weak) IBOutlet NSButton *cd_is3D;
@property (weak) IBOutlet NSSlider *cd_backgroundAlpha;
@property (weak) IBOutlet NSButton *cd_pictureBackground;

// Dock settings
@property (weak) IBOutlet NSButton *dock_SOAA;
@property (weak) IBOutlet NSButton *dock_DHI;
@property (weak) IBOutlet NSButton *dock_LDC;
@property (weak) IBOutlet NSButton *dock_MOH;
@property (weak) IBOutlet NSButton *dock_NB;
@property (weak) IBOutlet NSButton *dock_SAM;
@property (weak) IBOutlet NSButton *dock_REC;
@property (weak) IBOutlet NSSlider *dock_autohide;
@property (weak) IBOutlet NSSlider *dock_magnification;
@property (weak) IBOutlet NSSlider *dock_tilesize;
@property (weak) IBOutlet NSSlider *dock_appSpacers;
@property (weak) IBOutlet NSSlider *dock_docSpacers;

@property (weak) IBOutlet NSButton *cd_installSIMBL;

@end

NSMutableDictionary *prefCD;
NSMutableDictionary *pref;
NSMutableDictionary *prefd;