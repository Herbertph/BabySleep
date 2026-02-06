import Foundation

final class UsageLimitService {

    private let key = "sleep_entries_count"
    private let maxFreeEntries = 3

    func increment() {
        let current = UserDefaults.standard.integer(forKey: key)
        UserDefaults.standard.set(current + 1, forKey: key)
    }

    func canAddMore() -> Bool {
        let current = UserDefaults.standard.integer(forKey: key)
        return current < maxFreeEntries
    }

    func remaining() -> Int {
        let current = UserDefaults.standard.integer(forKey: key)
        return max(0, maxFreeEntries - current)
    }
}
