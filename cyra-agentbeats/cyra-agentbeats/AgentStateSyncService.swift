//
//  AgentStateSyncService.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import Foundation

struct CreateTaskRequest: Codable {
    let title: String
}

class AgentStateSyncService {
    private let baseURL = URL(string: "http://192.222.59.162:8000")!

    func fetchTasks() async throws -> [TaskModel] {
        let url = baseURL.appendingPathComponent("tasks")
        print("FETCHING FROM:", url.absoluteString)

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([TaskModel].self, from: data)
    }

    func createTask(title: String) async throws {
        let url = baseURL.appendingPathComponent("tasks")
        print("CREATING TASK AT:", url.absoluteString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = CreateTaskRequest(title: title)
        request.httpBody = try JSONEncoder().encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
