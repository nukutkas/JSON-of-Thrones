//
//  MainViewController.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 13.05.2021.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: URLS.characterApi.rawValue)
      
       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = characters[indexPath.row]
        guard let detailsVC = segue.destination as? CharacterDetailsViewController else { return }
        detailsVC.character = character
    }
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { characters in
            self.characters = characters
            self.tableView.reloadData()
        }
    }
}
