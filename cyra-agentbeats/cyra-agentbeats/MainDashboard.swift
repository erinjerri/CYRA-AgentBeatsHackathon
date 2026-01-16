//
//  MainDashboardView.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import SwiftUI

struct MainDashboardView: View {
    @State private var newTaskDescription: String = ""
    @State private var tasks: [TaskModel] = []
    let service = AgentStateSyncService()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("New task...", text: $newTaskDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 200)

                Button("Create") {
                    Task {
                        do {
                            try await service.createTask(description: newTaskDescription)
                            newTaskDescription = ""
                            tasks = try await service.fetchTasks()
                        } catch {
                            print("Task creation failed: \(error)")
                        }
                    }
                }
            }
            .padding()

            List(tasks, id: \.id) { task in
                Text(task.description)
            }
        }
        .task {
            do {
                tasks = try await service.fetchTasks()
            } catch {
                print("Initial fetch failed: \(error)")
            }
        }
    }
}
