import Foundation
import RxSwift

enum SerialAudioUnit {
    case audio(SHAudio)
    case pause(TimeInterval)
}

/// Basic audio building block
class SerialAudioPlayer {
    static let shared = SerialAudioPlayer()

    func enqueue(audioUnits: [SerialAudioUnit]) -> Completable {
        var completable: Completable = Completable.create { completable in
            completable(.completed)
            return Disposables.create {}
        }
        for audioUnit in audioUnits {
            let nextCompletable: Completable
            switch audioUnit {
            case .audio(let audio):
                nextCompletable = SpeechSynthesizer.shared.playRequest(audio: audio)
            case .pause(let pauseTime):
                nextCompletable = Completable.empty()
                    .delay(pauseTime, scheduler: MainScheduler.instance)
            }

            completable = completable.andThen(nextCompletable)
        }
        return completable
    }
}
