import Foundation
import RxSwift

protocol MainServicing {
    func getComingMovies() -> Observable<[String]>
    func getMovieDetails(movieID: String) -> Observable<Movie>
}

final class MainService: MainServicing {
    private lazy var bag = DisposeBag()
    
    private func getUrlRequest(from endpoint: String) -> URLRequest {
        let headers = [
            "x-rapidapi-host": "imdb8.p.rapidapi.com",
            "x-rapidapi-key": "1817af035emsh2c76d87f678b6a2p1b374fjsn05c83372078a"
        ]
        let url = URL(string: "https://imdb8.p.rapidapi.com/\(endpoint)?homeCountry=US&purchaseCountry=US&currentCountry=US")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func getComingMovies() -> Observable<[String]> {
        let response = Observable.from(["title/get-coming-soon-movies"])
            .map(getUrlRequest)
            .flatMap { urlRequest -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: urlRequest)
            }
            .share(replay: 1, scope: .whileConnected)
        
        let result = response
            .filter { 200..<300 ~= $0.response.statusCode }
            .map {  _, data -> [String] in
                return try JSONDecoder().decode([String].self, from: data)
        }
        
        return result
//        let response2 = Observable.from(["title/get-coming-soon-movies"])
//        .map(getUrlRequest)
//        .flatMap { urlRequest -> Observable<(response: HTTPURLResponse, data: Data)> in
//            URLSession.shared.rx.response(request: urlRequest)
//        }
//        .share(replay: 1, scope: .whileConnected)
    }
    
    func getMovieDetails(movieID: String) -> Observable<Movie> {
        let response = Observable.from(["title/get-details"])
            .map(getUrlRequest)
            .flatMap { urlRequest -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: urlRequest)
            }
            .share(replay: 1, scope: .whileConnected)
        
        let result = response
            .filter { 200..<300 ~= $0.response.statusCode }
            .map {  _, data -> Movie in
                return try JSONDecoder().decode(Movie.self, from: data)
            }
        
        return result
    }
}

struct Movie: Decodable {
    let type, id: String
    let image: Image
    let runningTimeInMinutes: Int
    let nextEpisode: String
    let numberOfEpisodes, seriesEndYear, seriesStartYear: Int
    let title, titleType: String
    let year: Int

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case id, image, runningTimeInMinutes, nextEpisode, numberOfEpisodes, seriesEndYear, seriesStartYear, title, titleType, year
    }
}

struct Image: Codable {
    let height: Int
    let id: String
    let url: String
    let width: Int
}
