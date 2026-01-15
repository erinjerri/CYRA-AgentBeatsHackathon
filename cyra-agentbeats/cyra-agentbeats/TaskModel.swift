//
//  TaskModel.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
//
import Foundation
import SwiftData

@Model
class TaskModel: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var priority: Int
    var status: String

    init(id: String, title: String, priority: Int = 1, status: String = "pending") {
        self.id = id
        self.title = title
        self.priority = priority
        self.status = status
    }
}
