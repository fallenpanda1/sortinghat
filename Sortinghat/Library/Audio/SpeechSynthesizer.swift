import AVFoundation
import RxCocoa
import RxSwift

/// Stripped down wrapper around AVSpeechSynthesizer that
/// provides completion blocks. Does not support
/// interrupts and crashes if you attempt to play
/// something before a previous play finishes.
class SpeechSynthesizer: NSObject {
    static let shared = SpeechSynthesizer()

    private let finishedPlayingRelay = PublishSubject<Never>()
    private let avSpeechSynthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()

        avSpeechSynthesizer.delegate = self
    }

    func playRequest(audio: SHAudio) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create {} }

            // just use hacky speech synthesizer for now
            let sentence = audio.rawValue.camelCaseToWords().withoutFirstWord()

            let utterance = AVSpeechUtterance(string: sentence)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate

            self.avSpeechSynthesizer.speak(utterance)

            return self.finishedPlayingRelay.subscribe(onCompleted: {
                completable(.completed)
            })
        }
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        finishedPlayingRelay.on(Event.completed)
    }
}

extension String {
    fileprivate func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) == true {
                return ($0 + " " + String($1))
            }
            else {
                return $0 + String($1)
            }
        }
    }

    fileprivate func withoutFirstWord() -> String {
        return components(separatedBy: " ").dropFirst().joined(separator: " ")
    }
}
