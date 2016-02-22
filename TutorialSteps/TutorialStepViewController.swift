import UIKit

class TutorialStepViewController: UIViewController {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    var backgroundImage: UIImage?
    var iconImage: UIImage?
    var text: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImageView.image = backgroundImage
        iconImageView.image = iconImage
        textLabel.text = text
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        print("moved to paretn view")
    }
}

