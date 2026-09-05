//
//  Task.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Foundation

struct Task {
    let title: String
    let taskDescription: String?
    let date: Date
    let priority: TaskPriority
    var isCompleted: Bool
    let id = UUID()
    
    init(title: String,taskDescription: String? = nil, date: Date, priority: TaskPriority, isCompleted: Bool) {
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
        self.priority = priority
        self.isCompleted = isCompleted
    }
}
