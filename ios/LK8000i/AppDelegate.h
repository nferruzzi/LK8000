//
//  AppDelegate.h
//  LK8000i
//
//  Created by Nicola Ferruzzi on 05/03/16.
//  Copyright © 2016 Nicola Ferruzzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Pods/Headers/Private/sdl2/SDL_uikitappdelegate.h"

@interface AppDelegate : SDLUIKitDelegate
@property (nonatomic, strong) UIWindow *uiWindow;
@end

