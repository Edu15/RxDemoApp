import UIKit

enum SettingsAction {
    case next
    case back
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: SettingsAction)
}

final class SettingsCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - SettingsCoordinating
extension SettingsCoordinator: SettingsCoordinating {
    func perform(action: SettingsAction) {
        switch action {
        case .next:
            let controller = MainFactory.make()
            viewController?.navigationController?.pushViewController(controller, animated: true)
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
