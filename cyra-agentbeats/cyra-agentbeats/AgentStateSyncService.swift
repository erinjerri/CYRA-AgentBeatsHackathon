//
//  AgentStateSyncService.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
//
import Foundation

class AgentStateSyncService {
    static let shared = AgentStateSyncService()
    private let baseURL = URL(string: "http://127.0.0.1:8000")!

    func pushTask(id: String, title: String) async {
        let payload: [String: Any] = [
            "user_utterance": title
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: payload) else { return }

        var request = URLRequest(url: baseURL.appendingPathComponent("/process"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
        } catch {
            print("Error pushing task:", error)
        }
    }
}
