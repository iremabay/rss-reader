import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var newsItems: [NewsItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        fetchNews()
    }

    func fetchNews() {
        let parser = RSSParser()
        parser.parseFeed(url: "http://feeds.bbci.co.uk/news/world/rss.xml") { items in
            self.newsItems = items
            print("Çekilen Haber Sayısı: \(items.count)")  // EKLEDİK
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let item = newsItems[indexPath.row]

        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.newsImageView.image = UIImage(systemName: "photo") // Şimdilik placeholder

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        let selectedItem = newsItems[indexPath.row]
        detailVC.newsTitle = selectedItem.title
        detailVC.newsDescription = selectedItem.description
        detailVC.image = UIImage(systemName: "photo") // İstersen burada da resmi çekebilirsin
        detailVC.newsLink = selectedItem.link

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

