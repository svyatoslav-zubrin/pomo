import Foundation
import Observation

@Observable
class PomoClock {
  private struct Const {
    static let emptyTime = "--:--"
  }

  private(set) var isRunning: Bool = false
  private(set) var time: String = Const.emptyTime
  private(set) var progress: Float = 0

  @ObservationIgnored
  private var secondsCounted: Int = 0 {
    didSet { updateTime() }
  }

  @ObservationIgnored
  private var timer: Timer? {
    didSet { self.isRunning = timer != nil }
  }

  @ObservationIgnored
  private var duration: Int // seconds

  @ObservationIgnored
  var onFinish: (()->())?

  @ObservationIgnored
  private lazy var formatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.minute, .second]
    f.zeroFormattingBehavior = .pad
    return f
  }()

  // Lifecycle
  init(duration: Int = 25 * 60) {
    self.duration = duration
    updateTime()
  }

  // Public
  func toggle() {
    if timer != nil {
      stop()
    } else {
      start()
    }
  }

  // Private
  private func start() {
    secondsCounted = -1
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      self?.tick()
    }
    timer.fire()
    self.timer = timer
  }

  private func stop() {
    guard let timer else { return }
    timer.invalidate()
    self.timer = nil
  }

  private func tick() {
    secondsCounted += 1

    if secondsCounted >= duration {
      stop()
      onFinish?()
    }
  }

  private func updateTime() {
    let theRest = TimeInterval(duration - secondsCounted)
    time = formatter.string(from: theRest) ?? Const.emptyTime
    progress = duration > 0 ? Float(duration - secondsCounted) / Float(duration) : 0
  }
}
