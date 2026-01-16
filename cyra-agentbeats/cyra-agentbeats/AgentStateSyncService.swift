//
//  AgentStateSyncService.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import Foundation

struct CreateTaskRequest: Codable {
    let description: String
}

class AgentStateSyncService {
    private let baseURL = URL(string: "http://localhost:8000")!

    // MARK: - Fetch tasks
    func fetchTasks() async throws -> [TaskModel] {
        let url = baseURL.appendingPathComponent("tasks")
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([TaskModel].self, from: data)
    }

    // MARK: - Create task
    func createTask(description: String) async throws {
        let url = baseURL.appendingPathComponent("tasks")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = CreateTaskRequest(description: description)
        request.httpBody = try JSONEncoder().encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
