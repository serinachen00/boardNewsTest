//  ViewController.swift
//  BoardNews
//
//  Created by Serina Chen on 5/2/20.
//  Copyright © 2020 Serina Chen. All rights reserved.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var thenews: [News]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchNews()
    }

    func fetchNews(){
        let urlReq = URLRequest(url: URL(string:"http://newsapi.org/v2/top-headlines?country=us&apiKey=42a5db6684444f29bbd634a4210488fd))")!)
        let task = URLSession.shared.dataTask(with: urlReq){
            (data,response,error) in
            if error != nil {
                print(error)
                return
            }
            self.thenews = [News]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]]{
                    
                    for articleFromJson in articlesFromJson {
                        let article = News()
                         if let title = articleFromJson["title"] as? String,
                        let author = articleFromJson["author"] as? String,
                        let desc = articleFromJson["description"] as? String,
                        let url = articleFromJson["url"] as? String,
                            let urlToImage = articleFromJson["urlToImage"] as? String{
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.thenews?.append(article)
                    }
                 
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
                } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as!NewsCell
        
        cell.title.text = self.thenews?[indexPath.item].headline
        cell.author.text = self.thenews?[indexPath.item].author
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thenews?.count ?? 0
        
    }
            

        
}

