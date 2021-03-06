import RxSwift

/// Check if wearer wants the given house
struct AskHouseAction: Action {
    let house: House

    func execute() -> Completable {
        print("Do you want to be a \(house.name)?")
        return Completable.empty()
    }
}

/// Declare wearer to a house
struct DeclareHouseAction: Action {
    let house: House

    func execute() -> Completable {
        let house = self.house

        let audio = SHAudio.declareHouse(house)

        // also go back to root
        SHActionTree.shared.goUpToRootBranch()

        return SerialAudioPlayer.shared
            .enqueue(audioUnits: [
                .audio(SHAudio.randomPredeclare()),
                .audio(audio)
            ])
    }
}

/// Navigate to a specific branch
struct GoToBranchAction: Action {
    let branch: ActionBranchNode

    func execute() -> Completable {
        SHActionTree.shared.goToBranch(branch)
        // complete immediately
        return Completable.empty()
    }
}

/// Speak a random think action
struct ThinkAction: Action {
    func execute() -> Completable {
        // also go back to root
        SHActionTree.shared.goUpToRootBranch()

        return SerialAudioPlayer.shared
            .enqueue(audioUnits: [
                .audio(SHAudio.randomThink())
            ])
    }
}
