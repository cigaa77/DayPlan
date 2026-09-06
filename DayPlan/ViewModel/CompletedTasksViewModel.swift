//
//  CompletedTasksViewModel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 06.09.26.
//

import Foundation

final class CompletedTasksViewModel{
    private let coreDataManager: TaskDataManaging
    private var tasks: [Task] = []
    
    init(coreDataManager: TaskDataManaging = CoreDataManager()) {
        self.coreDataManager = coreDataManager
        self.tasks = coreDataManager.fetchTasks()
    }
    
    var completedTasks: [Task] {
        return tasks.filter { task in
            task.isCompleted
        }.sorted { firstTask, secondTask in
            (firstTask.completedAt ?? .distantPast) > (secondTask.completedAt ?? .distantPast)
        }
    }
    
    var numberOfTasks: Int {
        return completedTasks.count
    }
    
    func task(at index: Int) -> Task {
        return completedTasks[index]
    }
    
    func completedDateText(for task: Task) -> String {
        guard let completedAt = task.completedAt else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy - HH:mm"
        
        return formatter.string(from: completedAt)
    }
    
    func deleteTask(at index: Int) {
        let selectedTask = completedTasks[index]
        
        coreDataManager.deleteTask(selectedTask)
        
        guard let taskIndex = tasks.firstIndex(where: { task in
            task.id == selectedTask.id
        }) else {return}
        
        tasks.remove(at: taskIndex)
    }
}
