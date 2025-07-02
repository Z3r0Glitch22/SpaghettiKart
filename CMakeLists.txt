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
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER com.example.spaghettikart
)

    target_include_directories(SpaghettiKart PRIVATE ios)
    target_link_libraries(SpaghettiKart PRIVATE "-framework UIKit" "-framework Metal" "-framework MetalKit" "-framework Foundation" "-framework GameController")

    # Link your engine C++ code here, example:
    # target_link_libraries(SpaghettiKart PRIVATE spaghetti_engine)

else()
    message(FATAL_ERROR "This CMakeLists is for iOS build only")
endif()
