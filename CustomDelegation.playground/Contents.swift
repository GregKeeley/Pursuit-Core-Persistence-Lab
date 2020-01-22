import UIKit



protocol SomeClassDelegate: AnyObject {
    func someFunc()
}
class SomeClass {
    weak var delegate: SomeClassDelegate?
    func someOtherFunc() {
        delegate?.someFunc()
    }
}




class ViewController: UIViewController {
    let someClass = SomeClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        someClass.delegate = self
    }
}
extension ViewController: SomeClassDelegate {
    func someFunc() {
        // code here
    }
}
