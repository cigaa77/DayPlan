//
//  ViewController.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private let viewModel = TaskListViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.backButtonTitle = "DayPlan"
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTask" {
            guard let addTaskViewController = segue.destination as? AddTaskViewController else {
                return
            }
            addTaskViewController.delegate = self
        }
        
        if segue.identifier == "toTaskDetail",
           let detailViewController = segue.destination as? TaskDetailViewController,
           let selectedTask = sender as? Task {
            detailViewController.task = selectedTask
        }
        
    }


}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let task = viewModel.task(at: indexPath.row, in: indexPath.section)
        cell.configure(title: task.title, time: viewModel.timeText(for: task), priority: task.priority, isCompleted: task.isCompleted)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Today"
        } else {
            return "Upcoming"
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row, in: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            //tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = viewModel.task(at: indexPath.row, in: indexPath.section)
        
        performSegue(withIdentifier: "toTaskDetail", sender: selectedTask)
    }
}

extension TaskListViewController: TaskTableViewCellDelegate {
    func didTapCompletionButton(in cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        viewModel.toggleTaskCompletion(at: indexPath.row, in: indexPath.section)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension TaskListViewController: AddTaskViewControllerDelegate {
    func addTaskViewController(_ controller: AddTaskViewController, didCreate: Task) {
        viewModel.addTask(didCreate)
        tableView.reloadData()
    }
}

extension TaskListViewController: EditTaskViewControllerDelegate {
    func editTaskViewController(_ controller: EditTaskViewController, didUpdate task: Task) {
        viewModel.updateTask(task)
        tableView.reloadData()
    }
}
