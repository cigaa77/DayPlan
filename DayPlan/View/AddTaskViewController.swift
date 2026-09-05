//
//  AddTaskViewController.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func addTaskViewController(
        _ controller: AddTaskViewController,
        didCreate: Task
    )
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!

    private let viewModel = AddTaskViewModel()

    private var selectedPriority: TaskPriority {
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            return .low
        case 1:
            return .medium
        case 2:
            return .high
        default:
            return .medium
        }
    }
    
    weak var delegate: AddTaskViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never

        titleTextField.layer.cornerRadius = 12
        titleTextField.clipsToBounds = true

        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 12,
                height: titleTextField.frame.height
            )
        )
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always

        detailsTextView.textContainerInset = UIEdgeInsets(
            top: 12,
            left: 8,
            bottom: 12,
            right: 8
        )
        detailsTextView.layer.cornerRadius = 12
        detailsTextView.clipsToBounds = true
        detailsTextView.text = "Add a description (optional)"
        detailsTextView.textColor = .placeholderText
        detailsTextView.delegate = self
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let title = titleTextField.text ?? ""
        guard viewModel.isTitleValid(title) else {
            showInvalidTitleAlert()
            return
        }

        let taskDescription: String?
        if detailsTextView.textColor == .placeholderText {
            taskDescription = nil
        } else {
            taskDescription = detailsTextView.text
        }

        let task = viewModel.createTask(
            title: title,
            taskDescription: taskDescription,
            date: datePicker.date,
            priority: selectedPriority
        )
        
        delegate?.addTaskViewController(self, didCreate: task)
        
        navigationController?.popViewController(animated: true)
    }
    private func showInvalidTitleAlert() {
        let alert = UIAlertController(
            title: "Missing title",
            message: "Please enter a Task title",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
extension AddTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a description (optional)"
            textView.textColor = .placeholderText
        }
    }
}
