//
//  CharacterDetailsViewController.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 31.05.2021.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: ImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    
    // MARK: - Public properties
    var character: Character!
    
    //MARK: - Private properties
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        configure(character)
    }
    
    // MARK: - Private methods
    private func configure(_ character: Character) {
        title = character.fullName
        descriptionLabel.text = character.description
        characterImageView.fetchImage(from: character.imageUrl)
    }
}
