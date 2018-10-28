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

        outputs.centerActionTitle
            .bind(to: centralActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.topActionTitle
            .bind(to: topActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.leftActionTitle
            .bind(to: leftActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.bottomActionTitle
            .bind(to: bottomActionLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.rightActionTitle
            .bind(to: rightActionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.bind(inputs: SwipeMenuViewModel.Input())
    }

    @IBAction func didSwipeUp(_ sender: Any) {
        print("up")
    }

    @IBAction func didSwipeLeft(_ sender: Any) {
        print("left")
    }

    @IBAction func didSwipeDown(_ sender: Any) {
        print("down")
    }

    @IBAction func didSwipeRight(_ sender: Any) {
        print("right")
    }

    @IBAction func didTap(_ sender: Any) {
        print("tap")
    }
}
