import Foundation

final class BabyProfileStorage {

    private let key = "baby_profile"

    func save(_ profile: BabyProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> BabyProfile? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let profile = try? JSONDecoder().decode(BabyProfile.self, from: data)
        else {
            return nil
        }

        return profile
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
