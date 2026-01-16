//
//  Backendtask.swift
//  cyra-agentbeats
//
//  Created by Erin Jerri on 1/15/26.
//
import Foundation

struct BackendTask: Identifiable, Codable {
    let id: String
    let description: String
    let status: String
}
