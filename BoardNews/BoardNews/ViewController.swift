import UIKit
class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var thenews: [News]? = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "BoardNews"
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        fetchNews()
    }
    func fetchNews(){
           let urlReq = URLRequest(url: URL(string:"http://newsapi.org/v2/top-headlines?country=us&apiKey=42a5db6684444f29bbd634a4210488fd")!)
           let task = URLSession.shared.dataTask(with: urlReq){
               (data,response,error) in
               if error != nil {
                   print(error)
                   return
               }
            DispatchQueue.main.async {
            
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
                       
                       self.tableView.reloadData()
                    print(self.thenews)
                    
                   } catch let error {
                   print(error)
               }
           }
        }
           task.resume()
       }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thenews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else{
            fatalError()
        }
        let data = thenews?[indexPath.row]
        cell.textLabel?.text = data?.headline
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //cell.textLabel?.text = data?.author
        //cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
     
        cell.detailTextLabel?.text = data?.desc
        cell.detailTextLabel?.textColor = UIColor.systemGray
        
        // has to put either guard or let to unwrap the value
        if let url = data?.imageUrl {
            
            cell.imageView?.downloadImage(from: (self.thenews?[indexPath.item].imageUrl!)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "web") as! WebviewViewController
        webvc.url = self.thenews?[indexPath.item].url
        self.present(webvc, animated: true,completion: nil)
        
    }
        
        
    }

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

class News: NSObject {

    var headline: String?
    var desc: String?
    var author: String?
    var url: String?
    var imageUrl: String?
}
