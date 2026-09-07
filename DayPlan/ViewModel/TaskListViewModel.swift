//
//  TaskListViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Foundation

enum TaskSection {
    case overdue
    case today
    case upcoming
}

final class TaskListViewModel {

    private let coreDataManager: TaskDataManaging

    private var tasks: [Task] = []

    init(coreDataManager: TaskDataManaging = CoreDataManager()) {
        self.coreDataManager = coreDataManager
        self.tasks = coreDataManager.fetchTasks()
    }
    private var overdueTasks: [Task] {
        return tasks.filter { task in
            task.date < Date() && !Calendar.current.isDateInToday(task.date)
                && !task.isCompleted
        }.sorted(by: { $0.date < $1.date })
    }
    private var todayTasks: [Task] {
        return tasks.filter { task in
            Calendar.current.isDateInToday(task.date) && !task.isCompleted
        }.sorted { t1, t2 in
            t1.date < t2.date
        }
    }
    private var upcomingTasks: [Task] {
        return tasks.filter { task in
            task.date > Date() && !Calendar.current.isDateInToday(task.date)
                && !task.isCompleted
        }.sorted(by: { $0.date < $1.date })
    }
    var visibleSections: [TaskSection] {
        var sections: [TaskSection] = []
        if !overdueTasks.isEmpty {
            sections.append(.overdue)
        }
        if !todayTasks.isEmpty {
            sections.append(.today)
        }
        if !upcomingTasks.isEmpty {
            sections.append(.upcoming)
        }
        
        return sections
    }
    var totalTaskCount: Int {
        return overdueTasks.count + todayTasks.count + upcomingTasks.count
    }
    func numberOfTasks(in section: Int) -> Int {
        let tasksSection = visibleSections[section]
        switch tasksSection {
        case .overdue:
            return overdueTasks.count
        case .today:
            return todayTasks.count
        case .upcoming:
            return upcomingTasks.count
        }
    }
    func task(at index: Int, in section: Int) -> Task {
        let taskSection = visibleSections[section]
        switch taskSection {
        case .overdue:
            return overdueTasks[index]
        case .today:
            return todayTasks[index]
        case .upcoming:
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
        let selectedTask = task(at: index, in: section)

        guard
            let taskIndex = tasks.firstIndex(where: { task in
                task.id == selectedTask.id
            })
        else { return }

        tasks[taskIndex].isCompleted.toggle()

        if tasks[taskIndex].isCompleted {
            tasks[taskIndex].completedAt = Date()
        } else {
            tasks[taskIndex].completedAt = nil
        }

        coreDataManager.updateTask(tasks[taskIndex])
    }
    func addTask(_ task: Task) {
        tasks.append(task)
        coreDataManager.saveTask(task)
    }
    func deleteTask(at index: Int, in section: Int) {
        let selectedTask = task(at: index, in: section)

        guard
            let taskIndex = tasks.firstIndex(where: { task in
                task.id == selectedTask.id
            })
        else {
            return
        }
        coreDataManager.deleteTask(tasks[taskIndex])
        tasks.remove(at: taskIndex)
    }
    func updateTask(_ task: Task) {
        guard
            let index = tasks.firstIndex(where: {
                $0.id == task.id
            })
        else { return }

        tasks[index] = task
        coreDataManager.updateTask(task)
    }
    func isOverdue(_ task: Task) -> Bool {
        return task.date < Date() && !Calendar.current.isDateInToday(task.date) && !task.isCompleted
    }

}
