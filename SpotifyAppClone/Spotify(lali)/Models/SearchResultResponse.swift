
import Foundation

struct SearchResultResponse: Codable {
    let albums: searchAlbumResponse
    let artists: searchArtistsResponse
    let playlists: searchPleylistsResponse
    let tracks: searchTracksResponse
}

struct searchAlbumResponse: Codable {
    let items: [Album]
}

struct searchArtistsResponse: Codable {
    let items: [Artist]
}

struct searchPleylistsResponse: Codable {
    let items: [Playlist]
}

struct searchTracksResponse: Codable {
    let items: [AudioTrack]
}
