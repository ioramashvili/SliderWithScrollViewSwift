import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pages = [BaseViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        
        let page1 = createAndAddTutorialStep(0, backgroundImageName: "bg_1", iconImageName: "icon_1", text: "PetShare is a pet photo sharing community.")
        let page2 = createAndAddTutorialStep(1, backgroundImageName: "bg_2", iconImageName: "icon_2", text: "Take pictures of your pet, and add filters or clipart to help them shine.")
        let page3 = createAndAddTutorialStep(2, backgroundImageName: "bg_3", iconImageName: "icon_3", text: "Share your photos via Facebook, email, Twitter, or instant message.")
        let page4 = createAndAddTutorialStep(3, backgroundImageName: "bg_4", iconImageName: "icon_4", text: "Rate other photos, give hearts, and follow pets you adore!")
        let page5 = createAndAddTutorialStep(4, backgroundImageName: "bg_5", iconImageName: "icon_5", text: "Set up a profile for your pet, show past photos, and let fans follow.")
        
        pages = [page1, page2, page3, page4, page5]
        
        pageControl.numberOfPages = pages.count
        
        let views = ["view": view, "page1": page1.view, "page2": page2.view, "page3": page3.view, "page4": page4.view, "page5": page5.view]
        let metrics = ["edgeMargin": 10, "betweenMargin": 20]
        
        let verticalConstraints =
        NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(verticalConstraints)
        
        let horizontalConstraints =
        NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-edgeMargin-[page1(==view)]-betweenMargin-[page2(==view)]-betweenMargin-[page3(==view)]-betweenMargin-[page4(==view)]-betweenMargin-[page5(==view)]-edgeMargin-|", options: [.AlignAllTop, .AlignAllBottom], metrics: metrics, views: views)
        NSLayoutConstraint.activateConstraints(horizontalConstraints)
    }
    
    @IBAction func pageChanged(sender: UIPageControl) {
        changePage(sender.currentPage)
    }
    
    private func changePage(currentPage: Int) {
        let pageWidth = CGRectGetWidth(scrollView.bounds)
        let targetContentOffsetX = CGFloat(currentPage) * pageWidth
        
        UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.scrollView.contentOffset.x = targetContentOffsetX
            }, completion: nil)
    }
    
    private func createAndAddTutorialStep(pageIndex: Int, backgroundImageName: String, iconImageName: String, text: String) -> BaseViewController {
        
        if pageIndex == 1 {
            let secondPage = storyboard!.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
            secondPage.view.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(secondPage.view)
            
            addChildViewController(secondPage)
            secondPage.didMoveToParentViewController(self)
            
            return secondPage
        }
        
        let tutorialStep = storyboard!.instantiateViewControllerWithIdentifier("TutorialStepViewController") as! TutorialStepViewController
        tutorialStep.view.translatesAutoresizingMaskIntoConstraints = false
        tutorialStep.backgroundImage = UIImage(named: backgroundImageName)
        tutorialStep.iconImage = UIImage(named: iconImageName)
        tutorialStep.text = text
        
        scrollView.addSubview(tutorialStep.view)
        
        addChildViewController(tutorialStep)
        tutorialStep.didMoveToParentViewController(self)
        
        return tutorialStep
    }
}

extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = CGRectGetWidth(scrollView.bounds)
        let pageFraction = scrollView.contentOffset.x / pageWidth
        
        pageControl.currentPage = Int(round(pageFraction))
        print("contentWidth: \(pageWidth)/\(scrollView.contentSize.width). offset.x: \(scrollView.contentOffset.x)")
    }
}
