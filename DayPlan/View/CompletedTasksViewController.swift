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
