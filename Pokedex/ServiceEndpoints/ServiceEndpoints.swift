import Foundation

protocol Routable {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMehod: HttpMehod { get }
}

enum HttpMehod: String {
    case get = "GET"
}

enum PokemonRoute: Routable {
    case id(Int)
    case name(String)

    var path: String {
        switch self {
        case .id(let id):
            return "ability/\(id)"
        case .name(let name):
            return "ability/\(name)"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .id, .name:
            return nil
        }
    }

    var httpMehod: HttpMehod {
        switch self {
        case .id, .name:
            return .get
        }
    }
}
