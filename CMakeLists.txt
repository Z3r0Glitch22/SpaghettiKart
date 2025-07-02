cmake_minimum_required(VERSION 3.21)
project(SpaghettiKart)

# Enable Objective-C and C++
enable_language(OBJC)
enable_language(CXX)

# Set to iOS Simulator platform
set(CMAKE_OSX_SYSROOT iphoneos)  # iphoneos for device, iphonesimulator for simulator
set(CMAKE_OSX_ARCHITECTURES arm64)  # arm64 is supported on M1+ simulator
set(CMAKE_OSX_DEPLOYMENT_TARGET "14.0")
set(CMAKE_XCODE_ATTRIBUTE_SUPPORTED_PLATFORMS iphonesimulator)
set(CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH YES)

# Disable code signing
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ""
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
# Set the bundle identifier
set_target_properties(SpaghettiKart PROPERTIES
    MACOSX_BUNDLE TRUE
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.yourcompany.spaghettikart"
    XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
# Include paths
target_include_directories(SpaghettiKart PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/ios
)
    



    #target_link_libraries(SpaghettiKart PRIVATE spaghetti_engine)


