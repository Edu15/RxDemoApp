import UIKit
import SnapKit

protocol SettingsDisplay: AnyObject {
}

private extension SettingsViewController.Layout {
}

final class SettingsViewController: ViewController<SettingsViewModelInputs, UIView> {
    fileprivate enum Layout { }
    
//    private lazy var backButton: UIBarButtonItem = {
//        let barButton = UIBarButtonItem(customView: CustomBackNavigationView())
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
//        barButton.customView?.addGestureRecognizer(gesture)
//        return barButton
//        }()
    
    private lazy var backButton: UIBarButtonItem = {
        let customView = CustomBackButton()
        customView.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return UIBarButtonItem(customView: customView)
    }()
    
    

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Change the navigationBar item frames
        if let customView = backButton.customView?.superview {
            customView.transform = CGAffineTransform(translationX: -8.0, y: 0)
        }
    }

    public override func buildViewHierarchy() {
    }
    
    public override func setupConstraints() {
    }

    public override func configureViews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(tapActionButton)
        )
    }
    
    @objc
    private func tapActionButton() {
        interactor.didAction()
    }
    
    @objc
    private func tapBack() {
        interactor.didBack()
    }
}

// MARK: SettingsDisplay
extension SettingsViewController: SettingsDisplay {
}
