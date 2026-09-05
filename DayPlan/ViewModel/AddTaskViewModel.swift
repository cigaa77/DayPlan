//
//  AddTaskViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Foundation

final class AddTaskViewModel {
    func isTitleValid(_ title: String) -> Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func createTask(
        title: String,
        taskDescription: String?,
        date: Date,
        priority: TaskPriority
    ) -> Task {
        return Task(
            title: title,
            taskDescription: taskDescription,
            date: date,
            priority: priority,
            isCompleted: false
        )
    }
}
