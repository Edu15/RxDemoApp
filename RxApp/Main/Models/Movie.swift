
import Foundation

struct Movie {
    let id: String
    let detail: MovieDetail?
}

struct MovieDetail: Decodable {
    let type, id: String
    let image: Image
    let runningTimeInMinutes: Int
    let nextEpisode: String?
    let numberOfEpisodes, seriesEndYear, seriesStartYear: Int?
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
