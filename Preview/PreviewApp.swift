import SwiftUI

@main
struct PreviewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                DispatchQueue.main.async() {
                    if let window = NSApplication.shared.windows.last {
                        // window.toggleFullScreen(nil)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
                            // Code you want to be delayed
                            NSCursor.setHiddenUntilMouseMoves(true)
                        }
                    }
                }
            }
        }
    }
}
