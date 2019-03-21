//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Hasmot Ali Hasu on 11/24/18.
//  Copyright © 2018 vitex vegundo. All rights reserved.
//

import UIKit
protocol TodoCellDelegate {
    func didRequestDelete (_ cell:ToDoTableViewCell)
    func didRequestComplate(_ cell:ToDoTableViewCell)
    
    
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    
    var delegate: TodoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteToDo(_ sender: Any) {
        if let delegateObject = self.delegate{
            delegateObject.didRequestDelete(self)
        }
    }
    @IBAction func completeToDo(_ sender: Any) {
        if let delegateObject = self.delegate{
            delegateObject.didRequestComplate(self)
        }    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
