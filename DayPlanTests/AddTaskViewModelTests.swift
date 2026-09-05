//
//  DayPlanTests.swift
//  DayPlanTests
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import Testing
@testable import DayPlan
import Foundation

struct AddTaskViewModelTests {
    
    let viewModel = AddTaskViewModel()
    
    // MARK: - Title Validation
    
    @Test func validTitleReturnsTrue() {
        let result = viewModel.isTitleValid("Gym")
        #expect(result == true)
    }
    
    @Test func emptyTitleReturnsFalse() {
        let result = viewModel.isTitleValid("")
        #expect(result == false)
    }
    
    @Test func whitespaceOnlyTitleReturnsFalse() {
        let result = viewModel.isTitleValid("   ")
        #expect(result == false)
    }

    @Test func newlineOnlyTitleReturnsFalse() {
        let result = viewModel.isTitleValid("\n\n")
        #expect(result == false)
    }
    
    // MARK: - Task Creation
    
    @Test func createTaskCreatesCorrectTask() {
        let date = Date()
        let task = viewModel.createTask(title: "Go to Gym", taskDescription: "BodyPump", date: date, priority: .high)
        #expect(task.title == "Go to Gym")
        #expect(task.taskDescription == "BodyPump")
        #expect(task.date == date)
        #expect(task.priority == .high)
        #expect(task.isCompleted == false)
    }
    
    @Test func createTaskAllowsNilDescription(){
        let date = Date()
        let task = viewModel.createTask(title: "Study German", taskDescription: nil, date: date, priority: .medium)
        #expect(task.taskDescription == nil)
    }
}
