//
//  TaskDetailViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import Foundation
import UIKit

final class TaskDetailViewModel {

    private let task: Task

    init(task: Task) {
        self.task = task
    }

    var titleText: String {
        return task.title
    }

    var descriptionText: String? {
        return task.taskDescription ?? "No description"
    }

    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy - HH:mm"
        return formatter.string(from: task.date)
    }

    var priorityText: String {
        switch task.priority {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }

    var priorityColor: UIColor {
        switch task.priority {
        case .high:
            return .systemRed
        case .medium:
            return .systemOrange
        case .low:
            return .systemGreen
        }
    }

    var statusText: String {
        if task.isCompleted {
            return "Completed"
        } else {
            return "Not Completed"
        }
        // return task.isCompleted ? "Completed : "Not Completed"
    }
    
    var statusImage: String {
        return task.isCompleted ? "checkmark.circle.fill" : "circle"
    }
}
