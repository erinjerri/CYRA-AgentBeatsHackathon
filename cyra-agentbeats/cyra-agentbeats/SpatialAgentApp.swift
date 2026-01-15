//
//  SpatialAgentApp.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
//
import SwiftUI
import SwiftData

struct SpatialAgentApp: App {
    var body: some Scene {
        WindowGroup {
            MainDashboardView()
        }
        .modelContainer(for: TaskModel.self)
    }
}
