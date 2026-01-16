//
//  MainDashboardView.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import SwiftUI

struct MainDashboardView: View {
    @State private var newTaskTitle: String = ""
    @State private var tasks: [TaskModel] = []
    let service = AgentStateSyncService()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("New task title...", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 200)

                Button("Create") {
                    print("BUTTON PRESSED")   // ← DEBUG PRINT

                    Task {
                        do {
                            try await service.createTask(title: newTaskTitle)
                            newTaskTitle = ""
                            tasks = try await service.fetchTasks()
                        } catch {
                            print("Task creation failed:", error)
                        }
                    }
                }
            }
            .padding()

            List(tasks, id: \.id) { task in
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                    Text("Status: \(task.status)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .task {
            do {
                tasks = try await service.fetchTasks()
            } catch {
                print("Initial fetch failed:", error)
            }
        }
    }
}
