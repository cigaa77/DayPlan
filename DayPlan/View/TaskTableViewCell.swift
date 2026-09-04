//
//  TaskTableViewCell.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject{
    func didTapCompletionButton(in cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    weak var delegate: TaskTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priorityLabel.clipsToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        priorityLabel.layer.cornerRadius = priorityLabel.bounds.height / 2
    }

    func configure(
        title: String,
        time: String,
        priority: TaskPriority,
        isCompleted: Bool
    ) {
        //titleLabel.text = title
        timeLabel.text = time
        priorityLabel.text = priority.rawValue.capitalized

        switch priority {
        case .high:
            priorityLabel.textColor = .systemRed
            priorityLabel.backgroundColor = .systemRed.withAlphaComponent(0.12)
        case .medium:
            priorityLabel.textColor = .systemYellow
            priorityLabel.backgroundColor = .systemYellow.withAlphaComponent(
                0.12
            )
        case .low:
            priorityLabel.textColor = .systemGreen
            priorityLabel.backgroundColor = .systemGreen.withAlphaComponent(
                0.12
            )
        }

        if isCompleted {
            completionButton.setImage(
                UIImage(systemName: "checkmark.circle.fill"),
                for: .normal
            )
        } else {
            completionButton.setImage(
                UIImage(systemName: "circle"),
                for: .normal
            )
        }
        if isCompleted {
            titleLabel.attributedText = NSAttributedString(
                string: title,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue
                ]
            )
            titleLabel.textColor = .secondaryLabel
            timeLabel.textColor = .tertiaryLabel
        } else {
            titleLabel.attributedText = nil //NSAttributedString(string: title)
            titleLabel.text = title
            titleLabel.textColor = .label
            timeLabel.textColor = .secondaryLabel
        }

        //priorityLabel.layer.cornerRadius = 8
        //priorityLabel.clipsToBounds = true

    }
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.didTapCompletionButton(in: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
