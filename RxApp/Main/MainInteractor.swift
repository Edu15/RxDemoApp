import UIKit
import RxSwift

protocol MainInteracting: AnyObject {
    func didAction()
    func didTapItem(movie: Movie)
    var movieList: Observable<[Movie]> { get }
    func getMovieDetail(fromId movieId: String, at row: Int) -> Observable<MovieDetail>
}

final class MainInteractor {
    private let service: MainServicing
    private let presenter: MainPresenting
    
    init(service: MainServicing, presenter: MainPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension MainInteractor: MainInteracting {
    var movieList: Observable<[Movie]> {
        service.getComingMovies()
            .map { array -> [Movie] in
                let newArray = array.map { string -> Movie in
                    let movieId = String(string.split(separator: "/").last ?? "")
                    return Movie(id: movieId, detail: nil)
                }
                return Array<Movie>(newArray.prefix(5))
            }
        .share(replay: 1, scope: .forever)
    }
    
    func getMovieDetail(fromId movieId: String, at row: Int) -> Observable<MovieDetail> {
        service.getMovieDetails(movieID: movieId)
//            Como salvar o estado retornado ???
//            .do { movieDetail in
//                movieList[row].detail = movieDetail
//            }
    }
    
    func didTapItem(movie: Movie) {
        print(movie.detail)
    }
    
    func didAction() {
//        let array = ["s", "d"]
//        let newArray = Array<String>(array.prefix(5))
    }
}
