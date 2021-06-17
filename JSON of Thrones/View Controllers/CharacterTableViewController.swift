//
//  MainViewController.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 13.05.2021.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    //MARK: - Private properties
    private var characters: [Character] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacter: [Character] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: URLS.characterApi.rawValue)
        setupSearchController()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        let character = isFiltering ? filteredCharacter[indexPath.row] : characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering ? filteredCharacter[indexPath.row] : characters[indexPath.row]
        guard let detailsVC = segue.destination as? CharacterDetailsViewController else { return }
        detailsVC.character = character
    }
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { characters in
            self.characters = characters
            self.tableView.reloadData()
        }
    }
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}

extension CharacterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredCharacter = characters.filter({ (character: Character) -> Bool in
            return character.fullName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
