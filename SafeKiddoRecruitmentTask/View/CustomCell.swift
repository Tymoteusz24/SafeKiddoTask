//
//  CustomCell.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var avatarId: UILabel!
    
    var viewModel : CellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.getImageFromUrl(completion: { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.customImageView.image = image
                    self?.layoutSubviews()
                }
            })
            
            avatarId.text = viewModel.avatarId
        }
    }
    
    
      override func prepareForReuse() {
          super.prepareForReuse()
          customImageView.image = UIImage(systemName: "clear")
      }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
