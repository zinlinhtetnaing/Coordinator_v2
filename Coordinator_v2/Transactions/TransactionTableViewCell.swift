//
//  TransactionTableViewCell.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 29/02/2024.
//

import UIKit

var clickMeButtonAction: ((_ cell: TransactionTableViewCell) -> Void)?

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clickedMeButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(indexPath: IndexPath) {
        clickedMeButton.tag = indexPath.row
        errorLabel.tag = indexPath.row
        textField.tag = indexPath.row
    }
    
    @IBAction func clickeMeBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        clickMeButtonAction?(self)
    }
    
}
