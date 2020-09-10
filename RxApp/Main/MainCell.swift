import UIKit
import SnapKit

final class MainCell: UITableViewCell, ViewConfiguration {
    var id: String?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.text = "-"
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "?"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "?"
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
//        iconView.backgroundColor = .lightGray
//        iconView.layer.cornerRadius = 20
        iconView.contentMode = .scaleAspectFit
        iconView.setContentHuggingPriority(.required, for: .horizontal)
        iconView.tintColor = .black
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
        self.id = movie.id
        titleLabel.text = movie.detail?.title ?? "?"
        yearLabel.text = String(movie.detail?.year ?? 0)
        timeLabel.text = "\(movie.detail?.runningTimeInMinutes ?? 0) minutos"
        iconView.image = UIImage(systemName: "film")
    }
    
    func buildViewHierarchy() {
        titleYearStackView.addArrangedSubview(titleLabel)
        titleYearStackView.addArrangedSubview(yearLabel)
        titleYearStackView.addArrangedSubview(timeLabel)
        
        contentStackView.addArrangedSubview(titleYearStackView)
        contentStackView.addArrangedSubview(iconView)
        addSubview(contentStackView)
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
//        iconView.snp.makeConstraints {
//            $0.width.height.
//        }
    }
}
