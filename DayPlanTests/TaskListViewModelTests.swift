//
//  TaskListViewModelTests.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import Foundation
import Testing

@testable import DayPlan

final class MockTaskDataManager: TaskDataManaging {

    var tasks: [DayPlan.Task] = []

    func saveTask(_ task: DayPlan.Task) {
        tasks.append(task)
    }

    func fetchTasks() -> [DayPlan.Task] {
        return tasks
    }

    func updateTask(_ task: DayPlan.Task) {
        guard
            let index = tasks.firstIndex(where: {
                $0.id == task.id
            })
        else { return }
        tasks[index] = task
    }

    func deleteTask(_ task: DayPlan.Task) {
        tasks.removeAll {
            $0.id == task.id
        }
    }
}

// MARK: - TaskListViewModel Tests

struct TaskListViewModelTests {

    // MARK: - Today / Upcoming

    @Test func todayTaskCountIsCorrect() {

        let mockManager = MockTaskDataManager()

        let todayTask1 = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let todayTask2 = Task(
            title: "Study German",
            date: Date(),
            priority: .medium,
            isCompleted: false
        )

        let tomorrow = Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date()
        )!

        let tomorrowTask = Task(
            title: "Shopping",
            date: tomorrow,
            priority: .low,
            isCompleted: false
        )

        mockManager.tasks = [
            todayTask1,
            todayTask2,
            tomorrowTask,
        ]

        let viewModel = TaskListViewModel(coreDataManager: mockManager)
        #expect(viewModel.numberOfTasks(in: 0) == 2)
    }

    @Test func upcomingTaskCountIsCorrect() {

        let mockManager = MockTaskDataManager()

        let tomorrow = Calendar.current.date(
            byAdding: .day,
            value: 2,
            to: Date()
        )!

        let tasks = [
            Task(
                title: "Task 1",
                date: tomorrow,
                priority: .high,
                isCompleted: false
            ),
            Task(
                title: "Task 2",
                date: tomorrow,
                priority: .medium,
                isCompleted: false
            ),
            Task(
                title: "Task 3",
                date: Date(),
                priority: .low,
                isCompleted: true
            ),
        ]

        mockManager.tasks = tasks

        let viewModel = TaskListViewModel(coreDataManager: mockManager)

        #expect(viewModel.numberOfTasks(in: 1) == 2)
    }

    // MARK: - Add

    @Test func addTaskIncreasesTaskCount() {

        let mockManager = MockTaskDataManager()
        let viewModel = TaskListViewModel(coreDataManager: mockManager)

        let task = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )
        viewModel.addTask(task)
        #expect(viewModel.numberOfTasks(in: 0) == 1)
        #expect(mockManager.tasks.count == 1)
    }

    // MARK: - Completion

    @Test func toggleTaskChangesCompletion() {

        let mockManager = MockTaskDataManager()

        let task = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )
        mockManager.tasks = [task]

        let viewModel = TaskListViewModel(coreDataManager: mockManager)

        viewModel.toggleTaskCompletion(at: 0, in: 0)

        let updatedTask = viewModel.task(at: 0, in: 0)

        #expect(updatedTask.isCompleted == true)
        #expect(mockManager.tasks[0].isCompleted == true)
    }

    // MARK: - Delete

    @Test func deleteTaskRemovesTask() {

        let mockManager = MockTaskDataManager()

        let task = Task(
            title: "Gym",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        mockManager.tasks = [task]

        let viewModel = TaskListViewModel(coreDataManager: mockManager)

        viewModel.deleteTask(at: 0, in: 0)

        #expect(viewModel.numberOfTasks(in: 0) == 0)
        #expect(mockManager.tasks.isEmpty == true)
    }

}
