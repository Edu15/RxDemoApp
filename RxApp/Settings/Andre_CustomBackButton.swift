import UIKit

private extension CustomBackButton.Layout {
    enum Font {
        static let button: UIFont = .systemFont(ofSize: 17)
    }
}

final class CustomBackButton: UIButton {
    fileprivate enum Layout {}
    
    convenience init() {
        self.init(type: .system)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        let attributedString = NSAttributedString(
            string: "Back custom 2222", attributes: [NSAttributedString.Key.font: Layout.Font.button]
        )
        
        setAttributedTitle(attributedString, for: .normal)
        setImage(#imageLiteral(resourceName: "chevron_left"), for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
//        contentEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
    }
}
