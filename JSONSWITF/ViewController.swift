//
//  ViewController.swift
//  JSONSWITF
//
//  Created by Abhishek Mehta on 02/01/18.
//  Copyright © 2018 Abhishek Mehta. All rights reserved.
//

import UIKit

struct Employee: Codable {
    var title: String
    var id: Int
    var user:User
    var labels:[_Labels]  //Nsarray
    var pull_request:pull_request? //NSDictionary
    var assignees:[assignees]? //NSarray 
 
}
struct User:Codable {
    var login: String
    var id: Int
    
}
struct _Labels:Codable {
    let id: Int
    let name: String
}

struct pull_request:Codable {
    let url: String
    let html_url: String
}


struct assignees:Codable {
    var login:String
    var id:Int
}

class ViewController: UIViewController {

    
    var articles:[Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.github.com/repositories/19438/issues"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData = try JSONDecoder().decode([Employee].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print(articlesData)
                    self.articles = articlesData
                   // self.collectionView?.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }

   

}

