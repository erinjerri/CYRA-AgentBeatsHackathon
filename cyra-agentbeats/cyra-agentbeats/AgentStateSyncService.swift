//
//  AgentStateSyncService.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import Foundation

class AgentStateSyncService {
    private let baseURL = BackendConfig.baseURL

    func fetchTasks() async throws -> [TaskModel] {
        let url = baseURL.appendingPathComponent("tasks")
        print("FETCHING FROM:", url.absoluteString)

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([TaskModel].self, from: data)
    }

    func createTask(title: String) async throws {
        let url = baseURL.appendingPathComponent("process")
        print("CREATING TASK AT:", url.absoluteString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Match FastAPI TaskPayload: "task" is an allowed field.
        let body = ["task": title]
        request.httpBody = try JSONEncoder().encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

