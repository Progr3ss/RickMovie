//
//  MovieListTableViewCell.swift
//  RickMovie
//
//  Created by Martin Chibwe on 4/30/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderlabel: UILabel!
    var downloadTask: URLSessionDownloadTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
      super.prepareForReuse()
      downloadTask?.cancel()
      downloadTask = nil
    }
    
    // MARK:- Public Methods
    func configure(for result: results) {
        
      nameLabel.text = result.name
      statusLabel.text = result.status
      genderlabel.text = result.gender
      movieImage.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: result.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg") {
        downloadTask = movieImage.loadImage(url: smallURL)
      }
    }

}
