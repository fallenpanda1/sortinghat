import RxCocoa
import RxSwift

/// Global action tree state for the SortingHat app
class SHActionTree {
    static let shared = SHActionTree()

    private let currentBranchRelay: BehaviorRelay<ActionBranchNode>
    var currentBranchObservable: Observable<ActionBranchNode> {
        return currentBranchRelay.asObservable()
    }

    init() {
        currentBranchRelay = BehaviorRelay(value: SHActionTreeSetup.root)
    }

    func goToBranch(_ branch: ActionBranchNode) {
        currentBranchRelay.accept(branch)
    }
}
