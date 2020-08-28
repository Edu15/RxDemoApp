import UIKit
import RxSwift

protocol MainInteracting: AnyObject {
    func didAction()
    var moviesList: Observable<[String]> { get }
    func getMovieDetail(fromId movieId: String) -> Observable<Movie>
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
    var moviesList: Observable<[String]> {
        service.getComingMovies()
            .map { array -> [String] in
                let newArray = array.map { string -> String in
                    String(string.split(separator: "/").last ?? "")
                }
                return Array<String>(newArray.prefix(5))
            }
    }
    
    func getMovieDetail(fromId movieId: String) -> Observable<Movie> {
        service.getMovieDetails(movieID: movieId)
    }
    
    func didAction() {
//        let array = ["s", "d"]
//        let newArray = Array<String>(array.prefix(5))
    }
}
