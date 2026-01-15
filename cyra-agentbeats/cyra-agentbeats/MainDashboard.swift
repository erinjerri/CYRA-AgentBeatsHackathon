//
//  MainDashboardView.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
//
import SwiftUI
import SwiftData

struct MainDashboardView: View {
    @Environment(\.modelContext) private var context

    var body: some View {
        VStack(spacing: 20) {
            Text("Green Agent Demo")
                .font(.largeTitle)

            Button("Create Task") {
                Task {
                    let id = UUID().uuidString
                    let title = "Buy groceries"

                    await AgentStateSyncService.shared.pushTask(id: id, title: title)

                    let newTask = TaskModel(id: id, title: title)
                    context.insert(newTask)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
