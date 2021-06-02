//
//  CharacterDetailsViewController.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 31.05.2021.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    
    // MARK: - Public properties
    var character: Character!
    
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        title = character.fullName
        descriptionLabel.text = character.description
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.character.imageUrl) else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
               // self.spinnerView.stopAnimating()
            }
        }
    }
}
