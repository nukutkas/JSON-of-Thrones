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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { characters in
            self.characters = characters
            self.tableView.reloadData()
        }
    }
}
