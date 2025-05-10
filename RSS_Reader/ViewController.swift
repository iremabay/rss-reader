import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let sampleNews = ["Haber 1", "Haber 2", "Haber 3"] // Örnek veri

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // Satır sayısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleNews.count
    }

    // Hücre içeriği
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let fullText = "Bu haberin tam açıklaması burada. Çok daha uzun bir metin olabilir."
        
        // Sadece ilk 50 karakteri gösterelim
        let shortText = String(fullText.prefix(50)) + "..."
        
        cell.titleLabel.text = sampleNews[indexPath.row]
        cell.descriptionLabel.text = shortText
        cell.newsImageView.image = UIImage(systemName: "photo") // Örnek bir görsel
        return cell
    }

    // Hücreye tıklanınca Detay Ekranına Geçiş
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        // Seçilen haber verilerini detay ekranına gönder
        detailVC.newsTitle = sampleNews[indexPath.row]
        detailVC.newsDescription = "Bu haberin tam açıklaması burada. Çok daha uzun bir metin olabilir."
        detailVC.image = UIImage(systemName: "photo") // Şimdilik placeholder görsel

        // Geçiş yap (Eğer Navigation Controller yoksa Embed In Navigation Controller yapman lazım!)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

