import UIKit
#if canImport(SafariServices)
import SafariServices
#endif
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {
    public init(url: URL) {
        self.url = url
    }

    public let url: URL

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> UIViewController {
#if canImport(SafariServices)
        return SFSafariViewController(url: url)
        #else
        return QRCodeViewController(url: url)
#endif
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

class QRCodeViewController: UIViewController {
    let url: URL
    private let imageView = UIImageView()
    private let label = UILabel()

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 600)
        widthConstraint.priority = .defaultHigh

        let heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)

        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint
        ])

        imageView.layer.magnificationFilter = .nearest
        imageView.layer.shouldRasterize = true
        imageView.contentMode = .scaleAspectFill

        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 1

        label.text = url.absoluteString
        
        imageView.image = generateQRCode(from: url.absoluteString)
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
          stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func generateQRCode(from string: String) -> UIImage? {

        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}


#Preview(body: {
    SafariView(url: URL(string: "https://google.com")!)
})
