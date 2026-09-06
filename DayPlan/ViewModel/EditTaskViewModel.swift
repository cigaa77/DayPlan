//
//  EditTaskViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 06.09.26.
//

import Foundation

final class EditTaskViewModel {
    let task: Task

    init(task: Task) {
        self.task = task
    }

    func updatedTask(
        title: String,
        taskDescription: String?,
        date: Date,
        priority: TaskPriority,
        isCompleted: Bool
    ) -> Task {
        return Task(
            id: task.id,
            title: title,
            taskDescription: taskDescription,
            date: date,
            priority: priority,
            isCompleted: isCompleted
        )
    }
    
    func isTitleValid(_ title: String) -> Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
