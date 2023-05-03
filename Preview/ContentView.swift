import SwiftUI

struct ContentView: View {
    var body: some View {
        ScreenSaverViewRepresented()
    }
}

struct ScreenSaverViewRepresented : NSViewRepresentable {
    func makeNSView(context: Context) -> AppleLogoScreenSaverView {
        return AppleLogoScreenSaverView();
    }
    
    func updateNSView(_ nsView: AppleLogoScreenSaverView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
