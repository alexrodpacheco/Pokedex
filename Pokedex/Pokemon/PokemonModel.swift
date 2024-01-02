import Foundation

// MARK: - Pokemon Model
struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let values: [Value]
    let names: [Name]
}

// MARK: - Name
struct Name: Decodable {
    let name: String
    let language: Value
}

// MARK: - Value
struct Value: Decodable {
    let name: String
    let url: String
}


struct PokemonHomeModel: Decodable {
    let count: Int
    let results: [Value]
}

// MARK: - PokemonSingleModel
struct PokemonSingleModel: Codable {
    let id: Int
    let name: String
    let baseExperience, height: Int
    let isDefault: Bool
    let order, weight: Int
    let abilities: [AbilityElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, weight, abilities
    }
}

// MARK: - AbilityElement
struct AbilityElement: Codable {
    let isHidden: Bool
        let slot: Int
        let ability: AbilityAbility

        enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
        case slot, ability
    }
}

// MARK: - AbilityAbility
struct AbilityAbility: Codable {
    let name: String
    let url: String
}
