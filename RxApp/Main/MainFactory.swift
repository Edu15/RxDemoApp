import Foundation

final class MainFactory {
    static func make() -> MainViewController {
        let service: MainServicing = MainService()
        let coordinator: MainCoordinating = MainCoordinator()
        let presenter: MainPresenting = MainPresenter(coordinator: coordinator)
        let viewModel = MainInteractor(service: service, presenter: presenter)
        let viewController = MainViewController(viewModel: viewModel)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
