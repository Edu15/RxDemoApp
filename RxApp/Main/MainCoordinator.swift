import UIKit

enum MainAction {
    case next
}

protocol MainCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: MainAction)
}

final class MainCoordinator: MainCoordinating {
    weak var viewController: UIViewController?
    
    func perform(action: MainAction) {
        switch action {
        case .next:
            let controller = SettingsFactory.make()
            viewController?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
