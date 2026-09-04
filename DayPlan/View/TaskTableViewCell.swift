//
//  TaskTableViewCell.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, time: String, priority: TaskPriority, isCompleted: Bool) {
        titleLabel.text = title
        timeLabel.text = time
        priorityLabel.text = priority.rawValue.capitalized
        
        if isCompleted {
            completionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            completionButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
