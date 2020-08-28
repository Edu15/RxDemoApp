import UIKit

protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func configureStyles()
    func buildLayout()
}

extension ViewConfiguration {
    public func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        configureStyles()
    }
    
    public func configureViews() { }

    public func configureStyles() { }
}

class ViewController<Interactor, V: UIView>: UIViewController, ViewConfiguration {
    public let interactor: Interactor
    public var rootView = V()
    
    public init(viewModel: Interactor) {
        self.interactor = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
    }
    
    override open func loadView() {
        view = rootView
    }
    
    open func configureStyles() { }
    
    open func configureViews() { }
    
    open func buildViewHierarchy() { }
    
    open func setupConstraints() { }
}

extension ViewController where Interactor == Void {
    convenience init(_ viewModel: Interactor = ()) {
        self.init(viewModel: viewModel)
    }
}
