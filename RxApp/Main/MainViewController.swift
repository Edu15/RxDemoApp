import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: ViewController<MainInteracting, UIView> {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindModelToTableView()
    }
    
    public override func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    public override func configureViews() {
        title = "Coming Movies"
        
        view.backgroundColor = .lightGray

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(tapActionButton)
        )
    }
    
    public override func setupConstraints() {
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindModelToTableView() {
        interactor.moviesList.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            
//            interactor.getMovieDetail(fromId: element).bind(to: cell.rx.base.textLabel?.text)
            cell.textLabel?.text = "\(element) @ row \(row)"
        }
            .disposed(by: disposeBag)
        
//        tableView.rx.willDisplayCell
//            .subscribe(onNext: { cell, indexPath in
//               // guard let cell = cell as? 
//            })
//            .disposed(by: disposeBag)
//            
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                self.presentAlert(for: value)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentAlert(for value: String) {
        let alert = UIAlertController(title: value, message: "Toque em \(value)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc
    private func tapActionButton() {
        interactor.didAction()
    }
}

//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        eventList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//            cell.textLabel?.text = eventList[indexPath.row]
//            return cell
//        }
//
//        cell.textLabel?.text = eventList[indexPath.row]
//        return cell
//    }
//}

//extension MainViewController: UITableViewDelegate {
//}

// MARK: View Model Outputs
extension MainViewController: MainDisplay {
    func displaySomething() {

    }
}



