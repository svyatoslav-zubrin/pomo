import SwiftUI

struct MainView: View {
  @State private var isSettingsPresented: Bool = false
  
  var body: some View {
    NavigationStack {
      TimerView()
        .frame(maxHeight: .infinity)
        .toolbar {
          ToolbarItemGroup(placement: .primaryAction) {
            Button(
              action: {
                print("Will show history")
              }, label: {
                Image(systemName: "list.bullet.rectangle")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 30)
              }
            )
            Button(
              action: {
                print("Will open pomodoro settings")
                isSettingsPresented = true
              }, label: {
                Image(systemName: "gearshape")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 30)
              }
            )
          }
        }
        .sheet(isPresented: $isSettingsPresented) {
          SettingsView()
        }
    }
  }
}

#Preview {
  MainView()
    .frame(width: 400, height: 200)
}
