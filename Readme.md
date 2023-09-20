# Safari View in SwiftUI
This project demonstrates how to display a Safari view controller or a custom QR code view controller in SwiftUI using UIViewControllerRepresentable.

## About
The SafariView struct wraps up the logic to display a URL in a view controller. If the SafariServices framework is available, it will display the URL in a SFSafariViewController. Otherwise, it falls back to a custom QRCodeViewController that generates a QR code image for the URL.

This allows integrating a Safari or QR code UIKit view controller into a SwiftUI view in a seamless way.

## Usage
To display a Safari view:

```
SafariView(url: URL(string: "https://www.example.com")!)
```
To display a QR code view:

```
SafariView(url: URL(string: "https://www.example.com")!)
// SafariServices not available
```
The SafariView wrapper handles instantiating the correct view controller under the hood.
![Screenshot 2023-09-20 at 12 52 01](https://github.com/theonlymo/SafariSwiftUI/assets/145556517/3f7d8eec-a486-45ba-b3ff-617fd1238655)

### Implementation
The key aspects are:

SafariView conforms to UIViewControllerRepresentable to create and update a UIViewController
SafariServices availability is checked with canImport compile time check
SFSafariViewController is used when available, otherwise defaults to QRCodeViewController
QRCodeViewController generates a QR code image from the URL

### Contributing
Pull requests are welcome. Please open an issue first to discuss what you would like to change.
