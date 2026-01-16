//
//  MainDashboardView.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
//
import SwiftUI
import SwiftData

struct MainDashboardView: View {
    @State private var tasks: [BackendTask] = []
    @State private var newTaskDescription = ""
    let service = TaskService()

    var body: some View {
        VStack {
            Text("Tasks")
                .font(.largeTitle)

            List(tasks) { task in
                VStack(alignment: .leading) {
                    Text(task.description)
                    Text(task.status)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            HStack {
                TextField("New task...", text: $newTaskDescription)
                Button("Create") {
                    Task {
                        try await service.createTask(description: newTaskDescription)
                        newTaskDescription = ""
                        tasks = try await service.fetchTasks()
                    }
                }
            }
            .padding()
        }
        .task {
            tasks = try! await service.fetchTasks()
        }
    }
}
