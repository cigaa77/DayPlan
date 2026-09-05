//
//  CoreDataManager.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import CoreData
import UIKit

final class CoreDataManager {

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func saveTask(_ task: Task) {
        let taskEntity = TaskEntity(context: context)
        taskEntity.id = task.id
        taskEntity.title = task.title
        taskEntity.taskDescription = task.taskDescription
        taskEntity.date = task.date
        taskEntity.priority = task.priority.rawValue
        taskEntity.isCompleted = task.isCompleted

        do {
            try context.save()
        } catch {
            print("Failed to save task: \(error)")
        }
    }

    func fetchTasks() -> [Task] {
        let request = TaskEntity.fetchRequest()

        do {
            let taskEntities = try context.fetch(request)

            let tasks = taskEntities.compactMap { entity -> Task? in
                guard let id = entity.id,
                    let title = entity.title,
                    let date = entity.date,
                    let priorityString = entity.priority,
                    let priority = TaskPriority(rawValue: priorityString)
                else {
                    return nil
                }

                return Task(
                    id: id,
                    title: title,
                    taskDescription: entity.taskDescription,
                    date: date,
                    priority: priority,
                    isCompleted: entity.isCompleted
                )
            }
            return tasks
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func updateTask(_ task: Task) {
        
    }

}
