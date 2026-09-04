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
        Task(
            title: "Study German Tomorrow",
            date: Calendar.current.date(
                byAdding: .day,
                value: 2,
                to: Date()
            )!,
            priority: .medium,
            isCompleted: false
        )
    ]
    private var todayTasks: [Task] {
        return tasks.filter { task in
            Calendar.current.isDateInToday(task.date)
        }
    }
    private var upcomingTasks: [Task] {
        return tasks.filter { task in
            task.date > Date() && !Calendar.current.isDateInToday(task.date)
        }
    }
    func numberOfTasks(in section: Int) -> Int {
        if section == 0 {
            return todayTasks.count
        } else {
            return upcomingTasks.count
        }
    }
    func task(at index: Int, in section: Int) -> Task {
        if section == 0 {
            return todayTasks[index]
        } else {
            return upcomingTasks[index]
        }
    }
    func timeText(for task: Task) -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(task.date) {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "dd.MM.yyyy - HH:mm"
        }
        return formatter.string(from: task.date)
    }
    func toggleTaskCompletion(at index: Int, in section: Int) {
        let selectedTask: Task
        
        if section == 0 {
            selectedTask = todayTasks[index]
        } else {
            selectedTask = upcomingTasks[index]
        }
        
        guard let taskIndex = tasks.firstIndex(where: { $0.id == selectedTask.id }) else {
            return
        }
        
        tasks[taskIndex].isCompleted.toggle()
    }

}
