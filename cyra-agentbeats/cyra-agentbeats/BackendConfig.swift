import Foundation

enum BackendConfig {
    static var baseURL: URL {
        let key = "API_BASE_URL"
        let raw = (Bundle.main.object(forInfoDictionaryKey: key) as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let raw, !raw.isEmpty, let url = URL(string: raw) else {
            preconditionFailure("Missing/invalid \(key) in Info.plist")
        }

        return url
    }
}

