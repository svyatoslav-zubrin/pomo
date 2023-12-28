import SwiftUI

struct TimerView: View {
  private var clock: PomoClock

  init() {
    self.clock = PomoClock(duration: 10)
    self.clock.onFinish = onFinish
  }

  var body: some View {
    VStack(spacing: 30) {
      VStack(spacing: 0) {
        Text(clock.time)
          .font(.largeTitle)
        ProgressView(value: clock.progress, total: 1)
          .tint(clock.isRunning ? .green : .secondary)
          .frame(width: 100)
        Text(clock.isRunning ? "working..." : "...")
      }

      Button(action: {
        clock.toggle()
      }, label: {
        Image(systemName: clock.isRunning ? "stop" : "play")
          .foregroundColor(clock.isRunning ? .red : .green)
          .padding()
      })
      .buttonStyle(.bordered)
    }
  }

  private func onFinish() {
    print("timer finished")

    // save the pomodoro
    //
  }
}

#Preview {
  TimerView()
    .frame(width: 200, height: 200)
}
