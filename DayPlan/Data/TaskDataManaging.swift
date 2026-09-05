//
//  TaskDataManaging.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

protocol TaskDataManaging {
    func saveTask(_ task: Task)
    func fetchTasks() -> [Task]
    func updateTask(_ task: Task)
    func deleteTask(_ task: Task)
}
