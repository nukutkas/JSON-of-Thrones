//
//  MainViewController.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 13.05.2021.
//

import UIKit

class MainViewController: UITableViewController {
    private let jsonURL = "https://thronesapi.com/api/v2/Characters"
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
      
       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.fullName

        DispatchQueue.global().async {
            guard let stringUrl = character.imageUrl else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
            }
        }

        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func fetchData() {
        guard let url = URL(string: jsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                self.characters = try decoder.decode([Character].self, from: data)
                print(self.characters)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
