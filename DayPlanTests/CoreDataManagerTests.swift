//
//  CoreDataManagerTests.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import CoreData
import Foundation
import Testing

@testable import DayPlan

@Suite(.serialized)
struct CoreDataManagerTests {

    func makeInMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "DayPlan")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        return container
    }

    // MARK: - Save

    @Test func saveTaskSavesTask() {
        let container = makeInMemoryContainer()
        let manager = CoreDataManager(context: container.viewContext)

        let task = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        manager.saveTask(task)

        let tasks = manager.fetchTasks()

        #expect(tasks.count == 1)
        #expect(tasks.first?.title == "Gym")
    }

    // MARK: - Fetch

    @Test
    func fetchTasksReturnsSavedTasks() {
        let container = makeInMemoryContainer()
        let manager = CoreDataManager(context: container.viewContext)

        let task1 = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let task2 = Task(
            title: "Study German",
            date: Date(),
            priority: .medium,
            isCompleted: false
        )

        manager.saveTask(task1)
        manager.saveTask(task2)

        let tasks = manager.fetchTasks()

        #expect(tasks.count == 2)
    }

    // MARK: - Update

    @Test func updateTaskUpdatesCompletion() {
        let container = makeInMemoryContainer()
        let manager = CoreDataManager(context: container.viewContext)

        var task = Task(
            title: "Gym",
            date: Date(),
            priority: .medium,
            isCompleted: false
        )
        manager.saveTask(task)

        task.isCompleted = true
        manager.updateTask(task)

        let tasks = manager.fetchTasks()

        #expect(tasks.first?.isCompleted == true)
    }

    // MARK: - Delete

    @Test func deleteTaskRemovesTask() {
        let container = makeInMemoryContainer()
        let manager = CoreDataManager(context: container.viewContext)

        var task = Task(
            title: "Gym",
            date: Date(),
            priority: .low,
            isCompleted: false
        )

        manager.saveTask(task)
        manager.deleteTask(task)

        let tasks = manager.fetchTasks()

        #expect(tasks.isEmpty)
    }
}
