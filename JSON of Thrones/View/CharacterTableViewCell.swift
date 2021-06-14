//
//  CharacterTableViewCell.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 26.05.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterImageView: ImageView!{
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    // MARK: - Public methods
    func configure(with character: Character) {
        nameLabel.text = character.fullName
        characterImageView.fetchImage(from: character.imageUrl )
    }
}
