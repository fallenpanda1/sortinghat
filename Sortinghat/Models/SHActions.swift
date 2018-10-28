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

        return Completable.create { completable in
            let audio = SHAudio.declareHouse(house)

            print("House \(house.name)!")

            // also go back to root
            SHActionTree.shared.goUpToRootBranch()

            let disposable = SerialAudioPlayer.shared
                .enqueue(audioUnits: [
                    .audio(SHAudio.randomPredeclare()),
                    .audio(audio)
                ])
                .subscribe(onCompleted: {
                    completable(.completed)
                })

            return disposable
        }
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
