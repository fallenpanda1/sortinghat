import RxCocoa
import RxSwift

/// Global action tree state for the SortingHat app
class SHActionTree {
    static let shared = SHActionTree()

    private let currentBranchRelay: BehaviorRelay<ActionBranchNode>
    var currentBranchObservable: Observable<ActionBranchNode> {
        return currentBranchRelay.asObservable()
    }
    private let rootBranch: ActionBranchNode

    init() {
        rootBranch = SHActionTreeSetup.root
        currentBranchRelay = BehaviorRelay(value: rootBranch)
    }

    func goUpToRootBranch() {
        currentBranchRelay.accept(rootBranch)
    }

    func goToBranch(_ branch: ActionBranchNode) {
        currentBranchRelay.accept(branch)
    }
}
