import UIKit
import SnapKit

class CustomBackNavigationView: UIView, ViewConfiguration {
    private lazy var arrowView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "chevron_left"))
        view.tintColor = .systemBlue
        return view
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Back custom"
        label.textColor = .systemBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(arrowView)
        addSubview(backLabel)
    }
    
    func setupConstraints() {
        arrowView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()//.offset(-8)
        }
        
        backLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(arrowView.snp.trailing).offset(4)
        }
    }
}
