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
        return viewModel.numberOfTasks
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = viewModel.task(at: indexPath.row)
        cell.configure(title: task.title, time: viewModel.timeText(for: task), priority: task.priority, isCompleted: task.isCompleted)
        return cell
    }
}

