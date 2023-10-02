# SwiftUIViewDebug

[![Swift 5.9](https://img.shields.io/badge/Swift-5.9-ED523F.svg?style=flat)](https://swift.org/)

## Background

In addition to `View._printChanges` and `ViewModifier._printChanges` for performance diagnosis, we can also use the method provided by `SwiftUI._ViewDebug` to get more debug info of SwiftUI View.

> Xcode's Debug View Hierarchy Window is probrobly using this method to get more debugging information.
> 
> Other UI debugging Application (such as [Lookin](https://github.com/hughkli/Lookin)) may also use such information to display more information of the SwiftUI view

## Installation

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/Kyle-Ye/SwiftUIViewDebug", from: "1.0.0"),
    ],
    targets: [
        .target(name: <#Target Name#>, dependencies: [
            .product(name: "SwiftUIViewDebug", package: "SwiftUIViewDebug"),
        ]),
    ]
)
```

## Example Usage

See more info on Example/ExampleApp

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        ._viewDebug { data in
            let string = String(data: data ?? Data(), encoding: .utf8) ?? ""
            print(string)
        }
    }
}
```

## Explaination

Currently only `_UIHostingView` / `NSHostingView` expose the `debugData` method. So we need to wrap it in a UIHostingController to get the debug data.

If you can intrested in the implementation of `_ViewDebug`, you can check my WIP implementation of [_ViewDebug](https://github.com/Kyle-Ye/OpenSwiftUI/blob/1bebc5d5d8a8c1228da9c262b599ac256f9f1467/Sources/OpenSwiftUI/View/Debug/TODO/_ViewDebug.swift)

## License

See LICENSE.txt