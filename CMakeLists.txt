cmake_minimum_required(VERSION 3.15)
project(SpaghettiKart)

set(CMAKE_CXX_STANDARD 17)

if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    message(STATUS "Configuring SpaghettiKart for iOS")

    set(SPAGHETTIKART_SRC
        ios/main_ios.mm
        ios/AppDelegate.mm
        ios/ViewController.mm
    )

    add_executable(SpaghettiKart ${SPAGHETTIKART_SRC})
    set_target_properties(SpaghettiKart PROPERTIES
    XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED NO
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
    XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ""
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER com.example.spaghettikart

    # Automatically gather all C source files in src/engine
file(GLOB_RECURSE ENGINE_SOURCES src/engine/*.c)

# Add to your iOS target
target_sources(SpaghettiKart PRIVATE ${ENGINE_SOURCES})

# Include the engine headers
target_include_directories(SpaghettiKart PRIVATE src/engine)

)
target_link_libraries(SpaghettiKart PRIVATE
    "-framework UIKit"
    "-framework Metal"
    "-framework MetalKit"
    "-framework Foundation"
    "-framework GameController"
    "-framework QuartzCore"
    "-framework UniformTypeIdentifiers"
)
    target_include_directories(SpaghettiKart PRIVATE
    ios
    engine
    game
    include
    )
    
    target_link_libraries(SpaghettiKart PRIVATE "-framework UIKit" "-framework Metal" "-framework MetalKit" "-framework Foundation" "-framework GameController")

    # Link your engine C++ code here, example:
    # target_link_libraries(SpaghettiKart PRIVATE spaghetti_engine)

else()
    message(FATAL_ERROR "This CMakeLists is for iOS build only")
endif()
