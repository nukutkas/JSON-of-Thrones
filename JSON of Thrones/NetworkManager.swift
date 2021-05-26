//
//  NetworkManager.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 13.05.2021.
//
import Foundation

//class NetworkManager {
//    
//    static let shared = NetworkManager()
//    
//    private let jsonURL = "https://thronesapi.com/api/v2/Characters"
//    
//    private init() {}
//    
//    func fetchData() {
//        guard let url = URL(string: jsonURL) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            guard let data = data else { return }
//            
//            let decoder = JSONDecoder()
//            
//            do {
//                let characters = try decoder.decode([Character].self, from: data)
//                print(characters)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//            
//        }.resume()
//    }
//}
