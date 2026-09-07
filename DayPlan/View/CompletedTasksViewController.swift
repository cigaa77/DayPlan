//
//  CompletedTasksViewController.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 06.09.26.
//

import UIKit

final class CompletedTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = CompletedTasksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        if viewModel.numberOfTasks == 0 {
            let label = UILabel()
            
            label.text = "No Completed Tasks\nCompleted tasks will appear here."
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .secondaryLabel
            
            tableView.backgroundView = makeEmptyStateView()
        } else {
            tableView.backgroundView = nil
        }
    }
    
    private func makeEmptyStateView() -> UIView {
        let containerView = UIView()

        let imageView = UIImageView(
            image: UIImage(systemName: "checkmark.circle")
        )
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "No Completed Tasks"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        let messageLabel = UILabel()
        messageLabel.text = "Completed tasks will appear here."
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        let stackView = UIStackView(
            arrangedSubviews: [
                imageView,
                titleLabel,
                messageLabel
            ]
        )

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8

        containerView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor
            ),
            stackView.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                greaterThanOrEqualTo: containerView.leadingAnchor,
                constant: 20
            ),
            stackView.trailingAnchor.constraint(
                lessThanOrEqualTo: containerView.trailingAnchor,
                constant: -20
            )
        ])

        return containerView
    }

}

extension CompletedTasksViewController: UITableViewDelegate,
    UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.numberOfTasks
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "completedTaskCell",
            for: indexPath
        )

        let task = viewModel.task(at: indexPath.row)
        //cell.textLabel?.text = task.title

        var content = cell.defaultContentConfiguration()
        content.text = task.title
        content.secondaryText =
            "Completed: \(viewModel.completedDateText(for: task))"
        content.image = UIImage(systemName: "checkmark.circle.fill")

        cell.contentConfiguration = content

        return cell
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedTask = viewModel.task(at: indexPath.row)
        performSegue(
            withIdentifier: "toCompletedTaskDetail",
            sender: selectedTask
        )
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            updateEmptyState()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCompletedTaskDetail",
            let taskDetailViewController = segue.destination
                as? TaskDetailViewController,
            let selectedTask = sender as? Task
        {
            taskDetailViewController.task = selectedTask
        }
    }
}
