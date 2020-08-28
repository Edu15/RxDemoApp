import UIKit
import SnapKit

final class MainCell: UITableViewCell, ViewConfiguration {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.text = "-"
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "-"
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.backgroundColor = .lightGray
        iconView.layer.cornerRadius = 30
        return iconView
    }()
    
    private lazy var titleYearStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        iconView.image = UIImage(systemName: "square.and.pencil")
    }
    
    func configure(with id: String) {
        titleLabel.text = id
        yearLabel.text = nil
        iconView.image = nil
    }
    
    func setupConstraints() {
        titleYearStackView.addArrangedSubview(titleLabel)
        titleYearStackView.addArrangedSubview(yearLabel)
        
        contentStackView.addArrangedSubview(titleYearStackView)
        contentStackView.addArrangedSubview(iconView)
        contentView.addSubview(contentStackView)
    }
    
    func buildViewHierarchy() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
    }
}
