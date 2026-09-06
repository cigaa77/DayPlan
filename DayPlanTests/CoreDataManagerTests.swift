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
    
    @Test
    func updateTaskUpdatesAllValues() {

        let container = makeInMemoryContainer()
        let context = container.viewContext
        let coreDataManager = CoreDataManager(context: context)

        let originalDate = Date()

        let originalTask = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: originalDate,
            priority: .high,
            isCompleted: false
        )

        coreDataManager.saveTask(originalTask)

        let newDate = originalDate.addingTimeInterval(3600)

        let updatedTask = Task(
            id: originalTask.id,
            title: "Study English",
            taskDescription: "45 minutes",
            date: newDate,
            priority: .low,
            isCompleted: true
        )

        coreDataManager.updateTask(updatedTask)

        let fetchedTasks = coreDataManager.fetchTasks()

        #expect(fetchedTasks.count == 1)

        let fetchedTask = fetchedTasks[0]

        #expect(fetchedTask.id == originalTask.id)
        #expect(fetchedTask.title == "Study English")
        #expect(fetchedTask.taskDescription == "45 minutes")
        #expect(fetchedTask.date == newDate)
        #expect(fetchedTask.priority == .low)
        #expect(fetchedTask.isCompleted == true)
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
