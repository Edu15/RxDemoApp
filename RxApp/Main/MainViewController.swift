import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: ViewController<MainInteracting, UIView> {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
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
        interactor.movieList.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MainCell.self)) { [weak self] row, movie, cell in
            cell.configure(with: movie)
//
//            guard cell.titleLabel.text == nil, let self = self else {
//                return
//            }
////            self.interactor.getMovieDetail(fromId: movie.id)
//            //.subscribeOn(MainScheduler.instance)   ???
//            .subscribe(onNext: { movieDetail in
//                DispatchQueue.main.async {
//                    cell.configure(with: Movie(id: movie.id, detail: movieDetail))
//                    //self.tableView.reloadData()
//                }
//            })
//            .disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
        
//        interactor.movieList.bind(to: tableView.rx.willDisplayCell() { cell, indexPath in
//        }
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                guard let self = self, let cell = cell as? MainCell, let movieID = cell.id else {
                    return
                }
                self.interactor.getMovieDetail(fromId: movieID, at: indexPath.row)
                    .subscribe(onNext: { movieDetail in
                        DispatchQueue.main.async {
                            cell.configure(with: Movie(id: movieID, detail: movieDetail))
                        }
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        
        tableView.rx
            .modelSelected(Movie.self)
            .subscribe(onNext:  { value in
                self.interactor.didTapItem(movie: value)
            })
            .disposed(by: disposeBag)
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



