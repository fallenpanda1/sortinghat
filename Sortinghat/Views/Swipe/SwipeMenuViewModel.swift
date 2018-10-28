import RxSwift
import RxCocoa

class SwipeMenuViewModel: ViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        // captures user selection of any of the branch children via swipes/taps
        let childPositionSelected: Observable<ActionBranchChildPosition>
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
        let childBranchSelectedObservable: Observable<ActionNode> = Observable
            .combineLatest(currentBranchObservable, inputs.childPositionSelected)
            .map { currentBranch, childPositionSelected in
                return currentBranch.childNode(forPosition: childPositionSelected)
            }
            .filterNil()

        childBranchSelectedObservable
            .subscribe(onNext: { selectedChild in
                switch selectedChild {
                case .leaf(let leafNode):
                    leafNode.action.execute()
                case .branch(let branchNode):
                    // when user selects a branch node, the action
                    // is to go into that branch
                    let action = GoToBranchAction(branch: branchNode)
                    action.execute()
                }
            })
            .disposed(by: disposeBag)
    }
}
