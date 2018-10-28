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
        let centerNodeTitle: Observable<String?>
        let topNodeTitle: Observable<String?>
        let leftNodeTitle: Observable<String?>
        let bottomNodeTitle: Observable<String?>
        let rightNodeTitle: Observable<String?>
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
            centerNodeTitle: currentBranchObservable.map { $0.centerNode?.name },
            topNodeTitle: currentBranchObservable.map { $0.topNode?.name },
            leftNodeTitle: currentBranchObservable.map { $0.leftNode?.name },
            bottomNodeTitle: currentBranchObservable.map { $0.bottomNode?.name },
            rightNodeTitle: currentBranchObservable.map { $0.rightNode?.name }
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
