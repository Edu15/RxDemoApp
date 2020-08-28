import Foundation

protocol MainPresenting: AnyObject {
    var viewController: MainDisplay? { get set }
    func displaySomething()
    func didNextStep(action: MainAction)
}

final class MainPresenter: MainPresenting {
    private let coordinator: MainCoordinating
    var viewController: MainDisplay?

    init(coordinator: MainCoordinating) {
        self.coordinator = coordinator
    }
    
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep(action: MainAction) {
        coordinator.perform(action: action)
    }
}
