func chopVegetables(completion: @escaping (Result<[Vegetable], CookingError>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        completion(.success([Vegetable(), Vegetable(), Vegetable()]))
    }
}

func chopVegetables(using knife: Knife = Knife()) async throws -> [Vegetable] {
    switch knife.sharpness {
    case .low: throw CookingError.knifeTooBlunt
    case _: return [Vegetable(), Vegetable(), Vegetable()]
    }
}

struct Vegetable {}

enum CookingError: Error {
    case knifeTooBlunt
    case benchTooDirty
}

struct Knife {
    enum Sharepness {
        case high
        case normal
        case low
    }

    private(set) var sharpness: Sharepness = .high
}
