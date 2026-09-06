//
//  TaskDetailViewController.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 05.09.26.
//

import UIKit

final class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!

    var task: Task?
    var viewModel: TaskDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let task = task else { return }

        viewModel = TaskDetailViewModel(task: task)

        //guard let viewModel = viewModel else { return }

        titleLabel.text = viewModel?.titleText
        descriptionLabel.text = viewModel?.descriptionText
        dateLabel.text = viewModel?.dateText
        priorityLabel.text = viewModel?.priorityText
        statusLabel.text = viewModel?.statusText

        priorityLabel.textColor = viewModel?.priorityColor

        statusImageView.image = UIImage(
            systemName: viewModel?.statusImage ?? "circle"
        )

    }

    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toEditTask", sender: task)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditTask",
            let editTaskViewController = segue.destination
                as? EditTaskViewController,
            let selectedTask = sender as? Task,
           let taskListViewController = navigationController?.viewControllers.first(where: {
               $0 is TaskListViewController
           }) as? TaskListViewController
        {
            editTaskViewController.task = selectedTask
            editTaskViewController.delegate = taskListViewController
        }
    }
}
