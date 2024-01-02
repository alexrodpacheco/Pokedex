import Foundation

class NetworkManager {
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchData<T: Decodable>(path: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + path) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                guard let data = data else { return }
                let pokemonData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(pokemonData))
            } catch let apiError {
                completion(.failure(apiError))
            }
        }
        task.resume()
    }
}

struct HomeService {
    private let manager = NetworkManager()
    
    func fetchPokemons(amountPokemon: Int) {
        manager.fetchData(path: "pokemon?limit=\(amountPokemon)", type: PokemonHomeModel.self) { result in
            switch result {
            case .success(let model):
                print(model.results.count)
                print(model.results[0])
            case .failure(_):
                break
            }
        }
    }
}

enum SinglePokemonNetWorkError: Error {
    case invalidURL
    case apiError
    case invalidData
}

class SinglePokemonService {
    
    private let manager = NetworkManager()
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchSinglePokemonGeneric(pokemonName: String) {
        manager.fetchData(path: "pokemon/\(pokemonName)", type: PokemonSingleModel.self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(_):
                break
            }
        }
    }
    
    func fetchSinglePokemon(path: String, id: Int, completion: @escaping (Result<PokemonSingleModel, SinglePokemonNetWorkError>) -> Void) {
        
        guard let url = URL(string: baseURL + "\(path)/\(id)/") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                completion(.failure(.apiError))
            }
            
            do {
                guard let data = data else { return }
                let apiData = try JSONDecoder().decode(PokemonSingleModel.self, from: data)
                completion(.success(apiData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        .resume()
    }
}

class SinglePokemonViewModel {
    private let service = SinglePokemonService()
    
    func showPokemonDataGenertic() {
        service.fetchSinglePokemonGeneric(pokemonName: "dragonite")
    }
    
    func showPokemonData(path: String, id: Int) {
        service.fetchSinglePokemon(path: path, id: id) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(_):
                break
            }
        }
    }
}
