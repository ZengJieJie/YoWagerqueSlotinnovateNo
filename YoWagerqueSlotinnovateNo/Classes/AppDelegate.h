
#pragma once

#include "platform/CCApplication.h"
/**
 @brief    The cocos2d Application.
 
 The reason for implement as private inheritance is to hide some interface call by Director.
 */
class  AppDelegate : public cocos2d::Application
{
public:
    AppDelegate(int width, int height);
    virtual ~AppDelegate();
    
    /**
     @brief    Implement Director and Scene init code here.
     @return true    Initialize success, app continue.
     @return false   Initialize failed, app terminate.
     */
    virtual bool applicationDidFinishLaunching() override;
    
    /**
     @brief  The function be called when the application is paused
     */
    virtual void onPause() override;
    
    /**
     @brief  The function be called when the application is resumed
     */
    virtual void onResume() override;
};
