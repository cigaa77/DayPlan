//
//  EditTaskViewModelTests.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 06.09.26.
//

import Foundation
import Testing
@testable import DayPlan

struct EditTaskViewModelTests {

    @Test
    func validTitleReturnsTrue() {

        let task = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: task)

        let result = viewModel.isTitleValid("Study English")

        #expect(result == true)
    }

    @Test
    func emptyTitleReturnsFalse() {

        let task = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: task)

        let result = viewModel.isTitleValid("")

        #expect(result == false)
    }

    @Test
    func whitespaceOnlyTitleReturnsFalse() {

        let task = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: task)

        let result = viewModel.isTitleValid("     ")

        #expect(result == false)
    }

    @Test
    func updatedTaskKeepsSameID() {

        let originalTask = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: originalTask)

        let updatedTask = viewModel.updatedTask(
            title: "Study English",
            taskDescription: "45 minutes",
            date: Date(),
            priority: .low,
            isCompleted: true
        )

        #expect(updatedTask.id == originalTask.id)
    }

    @Test
    func updatedTaskUpdatesAllValues() {

        let originalDate = Date()

        let originalTask = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: originalDate,
            priority: .high,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: originalTask)

        let newDate = originalDate.addingTimeInterval(3600)

        let updatedTask = viewModel.updatedTask(
            title: "Study English",
            taskDescription: "45 minutes",
            date: newDate,
            priority: .low,
            isCompleted: true
        )

        #expect(updatedTask.title == "Study English")
        #expect(updatedTask.taskDescription == "45 minutes")
        #expect(updatedTask.date == newDate)
        #expect(updatedTask.priority == .low)
        #expect(updatedTask.isCompleted == true)
    }

    @Test
    func updatedTaskAllowsNilDescription() {

        let originalTask = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .medium,
            isCompleted: false
        )

        let viewModel = EditTaskViewModel(task: originalTask)

        let updatedTask = viewModel.updatedTask(
            title: "Study German",
            taskDescription: nil,
            date: originalTask.date,
            priority: .medium,
            isCompleted: false
        )

        #expect(updatedTask.taskDescription == nil)
    }
}
