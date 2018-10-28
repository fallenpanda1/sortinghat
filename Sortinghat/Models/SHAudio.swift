import AVFoundation

enum SHAudio: String, CaseIterable {
    // ask
    case askGryffindor
    case askHufflepuff
    case askRavenclaw
    case askSlytherin

    // declare
    case declareGryffindor
    case declareHufflepuff
    case declareRavenclaw
    case declareSlytherin

    // delay
    case delayHmmm
    case delayLetsSee
    case delayWellThen

    // hint
    case hintGryffindor
    case hintHufflepuff
    case hintRavenclaw
    case hintSlytherin

    // predeclare
    case predeclareLetsGoWith
    case predeclareBetterBe
}

/// Convenience methods for accessing specific categories of audio
extension SHAudio {
    static func declareHouse(_ house: House) -> SHAudio {
        return SHAudio(rawValue: "declare\(house.name)")!
    }

    static func askHouse(_ house: House) -> SHAudio {
        return SHAudio(rawValue: "ask\(house.name)")!
    }

    static func hintHouse(_ house: House) -> SHAudio {
        return SHAudio(rawValue: "hint\(house.name)")!
    }

    static func randomDelay() -> SHAudio {
        return SHAudio.allCases
            .filter { $0.rawValue.hasPrefix("delay") }
            .randomElement()!
    }

    static func randomPredeclare() -> SHAudio {
        return allCases
            .filter { $0.rawValue.hasPrefix("predeclare") }
            .randomElement()!
    }
}
