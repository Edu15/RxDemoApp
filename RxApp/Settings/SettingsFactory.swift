import Foundation

final class SettingsFactory {
    static func make() -> SettingsViewController {
        let service: SettingsServicing = SettingsService()
        let coordinator: SettingsCoordinating = SettingsCoordinator()
        let presenter: SettingsPresenting = SettingsPresenter(coordinator: coordinator)
        let viewModel = SettingsViewModel(service: service, presenter: presenter)
        let viewController = SettingsViewController(viewModel: viewModel)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
