import Foundation

struct SleepRange: Codable {
    let min: Double
    let max: Double
}

final class SleepRangeService {

    private var ranges: [Int: SleepRange] = [:]

    init() {
        loadRanges()
    }

    private func loadRanges() {
        guard let url = Bundle.main.url(forResource: "SleepRanges", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: SleepRange].self, from: data)
        else {
            return
        }

        ranges = decoded.compactMapKeys { Int($0) }
    }

    func range(for ageInMonths: Int) -> SleepRange? {
        let sortedKeys = ranges.keys.sorted()

        for key in sortedKeys.reversed() {
            if ageInMonths >= key {
                return ranges[key]
            }
        }

        return nil
    }
}

private extension Dictionary {
    func compactMapKeys<T: Hashable>(_ transform: (Key) -> T?) -> [T: Value] {
        Dictionary<T, Value>(uniqueKeysWithValues: compactMap { key, value in
            transform(key).map { ($0, value) }
        })
    }
}
