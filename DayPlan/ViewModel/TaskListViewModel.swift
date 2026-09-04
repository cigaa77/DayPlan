//
//  TaskListViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Foundation

final class TaskListViewModel {

    private var tasks: [Task] = [
        Task(
            title: "Finish iOS Course",
            date: Date(),
            priority: .high,
            isCompleted: false
        ),
        Task(
            title: "Study German",
            date: Date(),
            priority: .medium,
            isCompleted: false
        ),
        Task(
            title: "Go to Gym",
            date: Date(),
            priority: .low,
            isCompleted: true
        ),
    ]
    var numberOfTasks: Int {
        return tasks.count
    }
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    func timeText(for task: Task) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: task.date)
    }

}
