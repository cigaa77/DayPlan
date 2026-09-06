//
//  TaskDetailViewModelTests.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 06.09.26.
//

import Foundation
import Testing
@testable import DayPlan
import UIKit

struct TaskDetailViewModelTests {

    @Test
    func titleTextReturnsTaskTitle() {

        let task = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.titleText == "Study German")
    }

    @Test
    func descriptionTextReturnsTaskDescription() {

        let task = Task(
            title: "Study German",
            taskDescription: "30 minutes",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.descriptionText == "30 minutes")
    }

    @Test
    func nilDescriptionReturnsNoDescription() {

        let task = Task(
            title: "Study German",
            taskDescription: nil,
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.descriptionText == "No description")
    }

    @Test
    func highPriorityReturnsCorrectValues() {

        let task = Task(
            title: "Study German",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.priorityText == "High")
        #expect(viewModel.priorityColor == .systemRed)
    }

    @Test
    func mediumPriorityReturnsCorrectValues() {

        let task = Task(
            title: "Study German",
            date: Date(),
            priority: .medium,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.priorityText == "Medium")
        #expect(viewModel.priorityColor == .systemOrange)
    }

    @Test
    func lowPriorityReturnsCorrectValues() {

        let task = Task(
            title: "Study German",
            date: Date(),
            priority: .low,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.priorityText == "Low")
        #expect(viewModel.priorityColor == .systemGreen)
    }

    @Test
    func completedTaskReturnsCompletedStatus() {

        let task = Task(
            title: "Study German",
            date: Date(),
            priority: .high,
            isCompleted: true
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.statusText == "Completed")
        #expect(viewModel.statusImage == "checkmark.circle.fill")
    }

    @Test
    func incompleteTaskReturnsNotCompletedStatus() {

        let task = Task(
            title: "Study German",
            date: Date(),
            priority: .high,
            isCompleted: false
        )

        let viewModel = TaskDetailViewModel(task: task)

        #expect(viewModel.statusText == "Not Completed")
        #expect(viewModel.statusImage == "circle")
    }
}
