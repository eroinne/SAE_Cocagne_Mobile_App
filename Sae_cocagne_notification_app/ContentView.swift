import SwiftUI
import UserNotifications

import SwiftUI

struct ContentView: View {
    @StateObject var viewController = ViewController()

    var body: some View {
        VStack {
            Text("Notification app")
                .padding()
            if let logoImage = UIImage(named: "logo", in: Bundle.main, with: nil) {
                Image(uiImage: logoImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        if viewController.notificationPermissionGranted {
                            print("Notification permission granted")
                            viewController.dispatchNotification()
                        }
                    }
            }
        }
        .onAppear {
            viewController.checkForNotificationPermission()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
  ContentView()
}
