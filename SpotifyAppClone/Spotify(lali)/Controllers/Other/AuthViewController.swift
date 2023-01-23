
import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    private let webWiew: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        return webView
    }()

    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sing In"
        view.backgroundColor = .systemBackground
        webWiew.navigationDelegate = self
        view.addSubview(webWiew)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webWiew.load(URLRequest(url: url))
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webWiew.frame = view.bounds

    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }

        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
            else{
            return
        }
        webView.isHidden = true

        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
}

