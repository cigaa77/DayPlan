//
//  Task.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Foundation

struct Task {
    let title: String
    let date: Date
    let priority: TaskPriority
    var isCompleted: Bool
    let id = UUID()
}
