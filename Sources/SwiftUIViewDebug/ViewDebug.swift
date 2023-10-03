import SwiftUI

extension View {
    public func _viewDebug(dataHandler: @escaping (Data?) -> Void) -> some View {
        DebugVC(view: self, dataHandler: dataHandler)
    }
}

extension View {
    /// Helper method for `_viewDebug(dataHandler:)`
    ///
    /// Convert the data to UTF8 string and print it to console.
    ///
    /// > Note:
    /// > If the view is complex, the string may be too large to be printed
    /// > to console. You should consider using other way to process the data.
    public func _viewDebug() -> some View {
        DebugVC(view: self) { data in
            guard let data,
                  let string = String(data: data, encoding: .utf8)
            else { return }
            print(string)
        }
    }

    /// Helper method for `_viewDebug(dataHandler:)`
    ///
    /// Write the data to provided file location.
    public func _viewDebug(exportTo file: URL) -> some View {
        DebugVC(view: self) { data in
            guard let data else {
                return
            }
            try? data.write(to: file)
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
typealias PlatformControllerRepresentable = UIViewControllerRepresentable
typealias PlatformHostingController = UIHostingController
typealias PlatformHostingView = _UIHostingView
#elseif os(macOS)
typealias PlatformControllerRepresentable = NSViewControllerRepresentable
typealias PlatformHostingController = NSHostingController
typealias PlatformHostingView = NSHostingView
#endif

private struct DebugVC<V: View>: PlatformControllerRepresentable {
    init(view: V, dataHandler: @escaping (Data?) -> Void) {
        self.view = view
        self.dataHandler = dataHandler
    }

    let view: V
    let dataHandler: (Data?) -> Void

    #if os(iOS) || os(tvOS) || os(visionOS)
    func makeUIViewController(context _: Context) -> DebugHostingController<V> {
        DebugHostingController(rootView: view, dataHandler: dataHandler)
    }

    func updateUIViewController(_: DebugHostingController<V>, context _: Context) {}
    #elseif os(macOS)
    func makeNSViewController(context _: Context) -> DebugHostingController<V> {
        DebugHostingController(rootView: view, dataHandler: dataHandler)
    }

    func updateNSViewController(_: NSViewControllerType, context _: Context) {}
    #endif
}

class DebugHostingController<V: View>: PlatformHostingController<V> {
    init(rootView: V, dataHandler: @escaping (Data?) -> Void) {
        self.dataHandler = dataHandler
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let dataHandler: (Data?) -> Void

    #if os(iOS) || os(tvOS) || os(visionOS)
    override func viewDidAppear(_: Bool) {
        if let hostingView = view as? PlatformHostingView<V> {
            let debugData = hostingView._viewDebugData()
            dataHandler(_ViewDebug.serializedData(debugData))
        }
    }
    #elseif os(macOS)
    override func viewDidAppear() {
        if let hostingView = view as? PlatformHostingView<V> {
            let debugData = hostingView._viewDebugData()
            dataHandler(_ViewDebug.serializedData(debugData))
        }
    }
    #endif
}
