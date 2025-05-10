import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!

    // MARK: - Variables to Receive Data
    var newsTitle: String?
    var newsDescription: String?
    var image: UIImage?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // View Yüklendiğinde Gelen Verileri Göster
        titleLabel.text = newsTitle
        descriptionLabel.text = newsDescription
        newsImageView.image = image
    }
}

