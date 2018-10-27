import UIKit

class SwipeMenuViewController: UIViewController {

    // must be set before VC usage
    var viewModel: SwipeMenuViewModel!

    @IBOutlet weak var centralActionLabel: UILabel!
    @IBOutlet weak var topActionLabel: UILabel!
    @IBOutlet weak var leftActionLabel: UILabel!
    @IBOutlet weak var bottomActionLabel: UILabel!
    @IBOutlet weak var rightActionLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        viewModel = SwipeMenuViewModel() // this needs to somehow gain access to the action graph

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setUpBindings()
    }

    private func setUpBindings() {
        // TODO: implement me
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
}
