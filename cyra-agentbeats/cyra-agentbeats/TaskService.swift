//
//  TaskService.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/15/26.
//

import Foundation

class TaskService {
    let baseURL = "http://127.0.0.1:8000"

    func fetchTasks() async throws -> [BackendTask] {
        let url = URL(string: "\(baseURL)/tasks")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([BackendTask].self, from: data)
    }

    func createTask(description: String) async throws {
        let url = URL(string: "\(baseURL)/process")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["description": description]
        request.httpBody = try JSONEncoder().encode(body)

        _ = try await URLSession.shared.data(for: request)
    }
}
