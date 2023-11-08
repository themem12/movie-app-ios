//
//  CustomMovieCell.swift
//  FilmsApp
//
//  Created by Guillermo Saavedra Dorantes  on 05/11/23.
//

import UIKit

class CustomMovieCell: UITableViewCell {
    
    static let nib = UINib(nibName: "CustomMovieCell", bundle: nil)
    static let identifier = "CustomMovieCell"
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
