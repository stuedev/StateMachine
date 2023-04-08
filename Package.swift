// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    
    name: "StateMachine",
    
    products:
        [
            .library(
                name: "StateMachine",
                targets: ["StateMachine"]),
        ],
    
    dependencies:
        [
            .package(url: "https://github.com/Quick/Nimble.git", branch: "main")
        ],
    
    targets:
        [
            .target(
                name: "StateMachine",
                dependencies:
                    [
                    ]
            ),
            
            .testTarget(
                name: "StateMachine Tests",
                dependencies:
                    [
                        "StateMachine",
                        "Nimble"
                    ]
            )
        ]
)
