cmake_minimum_required(VERSION 3.18)
project(SpaghettiKart)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_SYSROOT iphoneos)
set(CMAKE_OSX_DEPLOYMENT_TARGET "12.0")
set(CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH "NO")

# Source files
file(GLOB_RECURSE ENGINE_SRC
    "src/engine/*.c"
    "src/engine/*.cpp"
    "src/engine/*.h"
)

file(GLOB_RECURSE GAME_SRC
    "src/game/*.c"
    "src/game/*.cpp"
    "src/game/*.h"
)

set(IOS_WRAPPER
    ios/main_ios.mm
    ios/ViewController.mm
    ios/AppDelegate.mm
    ios/ViewController.h
    ios/AppDelegate.h
)

# Combine all sources
add_executable(SpaghettiKart
    ${ENGINE_SRC}
    ${GAME_SRC}
    ${IOS_WRAPPER}
)

# Target properties for iOS
set_target_properties(SpaghettiKart PROPERTIES
    MACOSX_BUNDLE TRUE
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.example.spaghettikart"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    # Uncomment and replace if you're signing locally:
    # XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "ABCDE12345"
)

# Link iOS frameworks
target_link_libraries(SpaghettiKart
    "-framework UIKit"
    "-framework Metal"
    "-framework MetalKit"
    "-framework Foundation"
    "-framework GameController"
)

# Include paths
target_include_directories(SpaghettiKart PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/ios
)
    



    #target_link_libraries(SpaghettiKart PRIVATE spaghetti_engine)


