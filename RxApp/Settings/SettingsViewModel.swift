import Foundation

protocol SettingsViewModelInputs: AnyObject {
    func didAction()
    func didBack()
}

final class SettingsViewModel {
    private let service: SettingsServicing
    private let presenter: SettingsPresenting

    init(service: SettingsServicing, presenter: SettingsPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - SettingsViewModelInputs
extension SettingsViewModel: SettingsViewModelInputs {
    func didAction() {
        presenter.didNextStep(action: .next)
    }
    
    func didBack() {
        presenter.didNextStep(action: .back)
    }
}
