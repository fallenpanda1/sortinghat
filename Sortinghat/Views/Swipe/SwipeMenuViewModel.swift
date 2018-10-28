import RxSwift
import RxCocoa

class SwipeMenuViewModel: ViewModel {
    struct Input {
    }

    struct Output {
        let title: Observable<String>
        let centerActionTitle: Observable<String?>
        let topActionTitle: Observable<String?>
        let leftActionTitle: Observable<String?>
        let bottomActionTitle: Observable<String?>
        let rightActionTitle: Observable<String?>
    }

    private let actionTree: SHActionTree
    private var currentBranchObservable: Observable<ActionBranchNode> {
        return actionTree.currentBranchObservable
    }

    init(actionTree: SHActionTree) {
        self.actionTree = actionTree
    }

    func outputBindings() -> SwipeMenuViewModel.Output {
        return Output(
            title: currentBranchObservable.map { $0.name },
            centerActionTitle: currentBranchObservable.map { $0.centerAction?.name },
            topActionTitle: currentBranchObservable.map { $0.topAction?.name },
            leftActionTitle: currentBranchObservable.map { $0.leftAction?.name },
            bottomActionTitle: currentBranchObservable.map { $0.bottomAction?.name },
            rightActionTitle: currentBranchObservable.map { $0.rightAction?.name }
        )
    }

    func bind(inputs: SwipeMenuViewModel.Input) {
        return
    }

    /// set the current branch
    func setActionBranch(_ actionBranch: ActionBranchNode) {
        // TODO: tell SHActionTree to update its branch node
    }
}
