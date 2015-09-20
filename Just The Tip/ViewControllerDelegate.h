//
//  ViewControllerDelegate.h
//  Just The Tip
//
//  Created by Tam Nguyen on 9/13/15.
//  Copyright © 2015 Tam Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MySettingsViewControllerDelegate <NSObject>
@required
- (void) getDefaults;
- (void) updateSubTotal: ( float ) value;
@end

@interface MySettingsViewControllerDelegate : NSObject

@end
