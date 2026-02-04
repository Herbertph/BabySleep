import Foundation

final class SleepStorageService {

    private let key = "sleep_entries"

    func save(_ entry: SleepEntry) {
        var entries = loadAll()
        entries.append(entry)

        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadAll() -> [SleepEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([SleepEntry].self, from: data)
        else {
            return []
        }
        return entries
    }

    func lastEntry() -> SleepEntry? {
        loadAll().last
    }
}
