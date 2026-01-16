//
//  TaskModel.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/12/26.
import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let priority: Int
    let status: String
}
