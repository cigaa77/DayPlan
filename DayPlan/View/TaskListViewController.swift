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
