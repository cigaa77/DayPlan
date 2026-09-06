//
//  EditTaskViewController.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import UIKit

protocol EditTaskViewControllerDelegate: AnyObject {
    func editTaskViewController(
        _ controller: EditTaskViewController,
        didUpdate task: Task
    )
}

class EditTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var completedSwitch: UISwitch!

    var task: Task?
    private var viewModel: EditTaskViewModel?

    weak var delegate: EditTaskViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let task = task else {
            return
        }

        titleTextField.text = task.title
        descriptionTextView.text = task.taskDescription
        datePicker.date = task.date
        completedSwitch.isOn = task.isCompleted

        switch task.priority {
        case .low:
            prioritySegmentedControl.selectedSegmentIndex = 0
        case .medium:
            prioritySegmentedControl.selectedSegmentIndex = 1
        case .high:
            prioritySegmentedControl.selectedSegmentIndex = 2
        }

        viewModel = EditTaskViewModel(task: task)
    }

    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text else {
            return
        }
        guard let viewModel = viewModel else { return }

        guard viewModel.isTitleValid(title) else {
            let alert = UIAlertController(
                title: "Invalid title",
                message: "Task title cannot be empty",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: "OK", style: .default)
            )
            present(alert, animated: true)
            return
        }

        let description = descriptionTextView.text
        let date = datePicker.date
        let isCompleted = completedSwitch.isOn

        let priority: TaskPriority
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            priority = .low
        case 1:
            priority = .medium
        case 2:
            priority = .high
        default:
            priority = .medium
        }

        let updatedTask = viewModel.updatedTask(
            title: title,
            taskDescription: description,
            date: date,
            priority: priority,
            isCompleted: isCompleted
        )

        delegate?.editTaskViewController(self, didUpdate: updatedTask)

        if let taskListViewController = navigationController?.viewControllers.first(where: { taskVC in
            taskVC is TaskListViewController
        }) as? TaskListViewController
            {
            navigationController?.popToViewController(taskListViewController, animated: true)
        }
    }

}
/*

















 */
