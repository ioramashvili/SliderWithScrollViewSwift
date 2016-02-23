import UIKit

protocol ImportantProtocol: class {
    var page: Int { get set }
}

class BaseViewController: UIViewController, ImportantProtocol {
    
    private var _page: Int = 0
    
    var page: Int {
        get {
            return _page
        }
        set {
            _page = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}