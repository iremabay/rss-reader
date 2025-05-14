import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets

    // MARK: - Variables to Receive Data
    var newsTitle: String?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var newsDescription: String?
    var image: UIImage?
    var newsLink: String?


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    // MARK: - Helper Methods
    private func configureView() {
        titleLabel.text = newsTitle
        descriptionLabel.text = newsDescription
        newsImageView.image = image
    }
}

