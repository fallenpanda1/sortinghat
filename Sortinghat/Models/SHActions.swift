import RxSwift

enum House: String {
    case gryffindor
    case hufflepuff
    case slytherin
    case ravenclaw

    var name: String {
        return self.rawValue.capitalized
    }
}

/// Declare wearer to a house
struct DeclareHouseAction: Action {
    let house: House

    func execute() -> Completable {
        let house = self.house
        return Completable.create { completable in
            let audio: SHAudio
            switch house {
            case .gryffindor: audio = .declareGryffindor
            case .hufflepuff: audio = .declareHufflepuff
            case .ravenclaw: audio = .declareRavenclaw
            case .slytherin: audio = .declareSlytherin
            }

            print("House \(house.name)!")

            // also go back to root
            SHActionTree.shared.goUpToRootBranch()

            let disposable = SerialAudioPlayer.shared
                .enqueue(audioUnits: [
                    .audio(.predeclareLetsGoWith),
                    .pause(0.2),
                    .audio(audio)
                ])
                .subscribe(onCompleted: {
                    completable(.completed)
                })

            return disposable
        }
    }
}

/// Check if wearer wants the given house
struct AskHouseAction: Action {
    let house: House

    func execute() -> Completable {
        print("Do you want to be a \(house.name)?")
        return Completable.empty()
    }
}

struct GoToBranchAction: Action {
    let branch: ActionBranchNode

    func execute() -> Completable {
        SHActionTree.shared.goToBranch(branch)
        // complete immediately
        return Completable.empty()
    }
}
