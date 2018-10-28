import RxCocoa
import RxSwift
import UIKit

class SwipeMenuViewController: UIViewController {
    private let disposeBag = DisposeBag()

    // must be set before VC usage
    var viewModel: SwipeMenuViewModel!

    @IBOutlet weak var centralActionLabel: UILabel!
    @IBOutlet weak var topActionLabel: UILabel!
    @IBOutlet weak var leftActionLabel: UILabel!
    @IBOutlet weak var bottomActionLabel: UILabel!
    @IBOutlet weak var rightActionLabel: UILabel!

    private let childPositionSelected = PublishRelay<ActionBranchChildPosition>()

    required init?(coder aDecoder: NSCoder) {
        // TODO: kind of hacky...
        viewModel = SwipeMenuViewModel(actionTree: SHActionTree.shared)

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setUpBindings()
    }

    private func setUpBindings() {
        let outputs = viewModel.outputBindings()

        outputs.centerNodeTitle
            .bind(to: centralActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.topNodeTitle
            .bind(to: topActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.leftNodeTitle
            .bind(to: leftActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.bottomNodeTitle
            .bind(to: bottomActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.rightNodeTitle
            .bind(to: rightActionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.bind(inputs: SwipeMenuViewModel.Input(
            childPositionSelected: childPositionSelected.asObservable()
        ))
    }

    @IBAction func didSwipeUp(_ sender: Any) {
        childPositionSelected.accept(.top)
    }

    @IBAction func didSwipeLeft(_ sender: Any) {
        childPositionSelected.accept(.left)
    }

    @IBAction func didSwipeDown(_ sender: Any) {
        childPositionSelected.accept(.bottom)
    }

    @IBAction func didSwipeRight(_ sender: Any) {
        childPositionSelected.accept(.right)
    }

    @IBAction func didTap(_ sender: Any) {
        childPositionSelected.accept(.center)
    }
}
