import Foundation

protocol SettingsPresenting: AnyObject {
    var viewController: SettingsDisplay? { get set }
    func didNextStep(action: SettingsAction)
}

final class SettingsPresenter {
    private let coordinator: SettingsCoordinating
    weak var viewController: SettingsDisplay?

    init(coordinator: SettingsCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - SettingsPresenting
extension SettingsPresenter: SettingsPresenting {
    func didNextStep(action: SettingsAction) {
        coordinator.perform(action: action)
    }
}
