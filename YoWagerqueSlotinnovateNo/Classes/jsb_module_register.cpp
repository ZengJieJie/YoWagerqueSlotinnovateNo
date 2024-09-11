

#include "cocos2d.h"

#include "cocos/scripting/js-bindings/manual/jsb_module_register.hpp"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"

#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_auto.hpp"

#include "cocos/scripting/js-bindings/manual/jsb_global.h"
#include "cocos/scripting/js-bindings/manual/jsb_node.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_conversions.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_opengl_manual.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_platform.h"
#include "cocos/scripting/js-bindings/manual/jsb_cocos2dx_manual.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_xmlhttprequest.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_cocos2dx_network_manual.h"
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_network_auto.hpp"
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_extension_auto.hpp"

#if USE_GFX_RENDERER
#include "cocos/scripting/js-bindings/auto/jsb_gfx_auto.hpp"
#include "cocos/scripting/js-bindings/auto/jsb_renderer_auto.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_gfx_manual.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_renderer_manual.hpp"
#endif

#if USE_SOCKET
#include "cocos/scripting/js-bindings/manual/jsb_websocket.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_socketio.hpp"
#if USE_WEBSOCKET_SERVER
#include "cocos/scripting/js-bindings/manual/jsb_websocket_server.hpp"
#endif
#endif // USE_SOCKET

#if USE_AUDIO
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_audioengine_auto.hpp"
#endif

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
#include "cocos/scripting/js-bindings/manual/JavaScriptObjCBridge.h"
#endif

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#include "cocos/scripting/js-bindings/manual/JavaScriptJavaBridge.h"
#endif

#if USE_GFX_RENDERER && USE_MIDDLEWARE
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_editor_support_auto.hpp"

#if USE_SPINE
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_spine_auto.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_spine_manual.hpp"
#endif

#if USE_DRAGONBONES
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_dragonbones_auto.hpp"
#include "cocos/scripting/js-bindings/manual/jsb_dragonbones_manual.hpp"
#endif

#if USE_PARTICLE
#include "cocos/scripting/js-bindings/auto/jsb_cocos2dx_particle_auto.hpp"
#endif

#endif // USE_MIDDLEWARE

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_OPENHARMONY)

#if USE_VIDEO
#include "cocos/scripting/js-bindings/auto/jsb_video_auto.hpp"
#endif

#if USE_WEB_VIEW
#include "cocos/scripting/js-bindings/auto/jsb_webview_auto.hpp"
#endif

#endif // (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_OPENHARMONY)

using namespace cocos2d;

bool jsb_register_all_modules()
{
    se::ScriptEngine* se = se::ScriptEngine::getInstance();

    se->addBeforeInitHook([](){
        JSBClassType::init();
    });

    se->addBeforeCleanupHook([se](){
        se->garbageCollect();
        PoolManager::getInstance()->getCurrentPool()->clear();
        se->garbageCollect();
        PoolManager::getInstance()->getCurrentPool()->clear();
    });

    se->addRegisterCallback(jsb_register_global_variables);
    se->addRegisterCallback(JSB_register_opengl);
    se->addRegisterCallback(register_all_engine);
    se->addRegisterCallback(register_all_cocos2dx_manual);
    se->addRegisterCallback(register_platform_bindings);
    
    se->addRegisterCallback(register_all_network);
    se->addRegisterCallback(register_all_cocos2dx_network_manual);
    se->addRegisterCallback(register_all_xmlhttprequest);
    // extension depend on network
    se->addRegisterCallback(register_all_extension);

#if USE_GFX_RENDERER
    se->addRegisterCallback(register_all_gfx);
    se->addRegisterCallback(jsb_register_gfx_manual);
    se->addRegisterCallback(register_all_renderer);
    se->addRegisterCallback(jsb_register_renderer_manual);
#endif

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
    se->addRegisterCallback(register_javascript_objc_bridge);
#endif

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    se->addRegisterCallback(register_javascript_java_bridge);
#endif

#if USE_AUDIO
    se->addRegisterCallback(register_all_audioengine);
#endif
    
#if USE_SOCKET
    se->addRegisterCallback(register_all_websocket);
    se->addRegisterCallback(register_all_socketio);
#if USE_WEBSOCKET_SERVER
    se->addRegisterCallback(register_all_websocket_server);
#endif
#endif

#if USE_GFX_RENDERER && USE_MIDDLEWARE
    se->addRegisterCallback(register_all_cocos2dx_editor_support);

#if USE_SPINE
    se->addRegisterCallback(register_all_cocos2dx_spine);
    se->addRegisterCallback(register_all_spine_manual);
#endif

#if USE_DRAGONBONES
    se->addRegisterCallback(register_all_cocos2dx_dragonbones);
    se->addRegisterCallback(register_all_dragonbones_manual);
#endif

#if USE_PARTICLE
    se->addRegisterCallback(register_all_cocos2dx_particle);
#endif

#endif // USE_MIDDLEWARE

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)

#if USE_VIDEO
    se->addRegisterCallback(register_all_video);
#endif

#if USE_WEBVIEW
    se->addRegisterCallback(register_all_webview);
#endif

#elif (CC_TARGET_PLATFORM == CC_PLATFORM_OPENHARMONY)

#if USE_WEBVIEW
    se->addRegisterCallback(register_all_webview);
#endif

#endif // (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)

    se->addAfterCleanupHook([](){
        PoolManager::getInstance()->getCurrentPool()->clear();
        JSBClassType::destroy();
    });
    return true;
}
