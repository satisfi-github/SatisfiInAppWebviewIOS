//
//  WKWebViewService.swift
//  WKWebViewService
//
//  Created by Vinay Bharwani on 2/18/21.
//
/// This code is commented as UIWebView is deprecated for new apps
//
//import UIKit
//
//class UIWebViewController: UIViewController {
//
//	open var headerBarTitle:String?
//
//	open var showHeaderBar: Bool = true
//	open  var showFooterBar: Bool = true
//
//	init(with urlString:String) {
//		self.webUrl = urlString
//		super.init(nibName: nil, bundle: nil)
//	}
//
//	public required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//	}
//
//	//	MARK: - Properties (private)
//
//	private var webUrl:String?
//
//	private lazy var webView: UIWebView = {
//		let webView = UIWebView(frame: self.view.bounds)
//		webView.translatesAutoresizingMaskIntoConstraints = false
//		return webView
//	}()
//
//	private let activityIndicator = UIActivityIndicatorView(style: .large)
//
//    lazy var backButton = UIBarButtonItem(title: "\u{1438}", style: .plain, target: self, action: #selector(backwardAction))
//
//	lazy var forwardButton = UIBarButtonItem(title: "\u{1433}", style: .plain, target: self, action: #selector(forwardAction))
//
//
//    //    MARK: - Actions
//    @objc func backwardAction() {
//        webView.stopLoading()
//        if webView.canGoBack {
//            webView.goBack()
//        }
//        updateToolBar()
//    }
//
//    @objc func forwardAction() {
//        webView.stopLoading()
//        if webView.canGoForward {
//            webView.goForward()
//        }
//        updateToolBar()
//    }
//
//    @objc func refreshAction() {
//        webView.stopLoading()
//        webView.reload()
//    }
//
//    @objc func doneAction() {
//        if (self.presentedAsModel) {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    private var presentedAsModel: Bool {
//        get {
//            return (self.presentingViewController != nil && self.showHeaderBar)
//        }
//    }
//
//	//	MARK: - View Controller
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		setupUI()
//		loadWebView()
//	}
//
//    override func viewWillLayoutSubviews() {
//        setupActivityIndicator()
//    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.view.endEditing(true)
//    }
//
//	//	MARK: - Functions
//	private func setupUI() {
//		webView.delegate = self
//
//		self.view.backgroundColor = .white
//		self.view.addSubview(webView)
//
//		NSLayoutConstraint.activate([
//			webView.topAnchor
//				.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//			webView.leftAnchor
//				.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
//			webView.bottomAnchor
//				.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//			webView.rightAnchor
//				.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
//		])
//
//		/// Turn off the vertical and horizontal scroll indicators of WebView
//		webView.scrollView.showsVerticalScrollIndicator = false
//		webView.scrollView.showsHorizontalScrollIndicator = false
//		webView.scrollView.bounces = false
//
//		setupNavigationBar(show: showHeaderBar)
//		setupBottomToolbar(show: showFooterBar)
//
//		if (presentedAsModel) {
//			showDoneButton()
//		}
//
//		enableSwipeGesture(show: showHeaderBar)
//	}
//
//	private func loadWebView(){
//		guard let urlString = webUrl else {
//			displayErrorAlert(message: "URL is not valid!")
//			return
//		}
//		let urlStr = urlString.hasPrefix("https://") || urlString.hasPrefix("http://") ? urlString : "http://" + urlString
//
//		guard let url = URL(string: urlStr) else {
//			displayErrorAlert(message: "URL is not valid!")
//			return
//		}
//		self.webView.loadRequest(URLRequest(url: url))
//	}
//    /// To setup top header bar
//    private func setupNavigationBar(show showBar : Bool) {
//        if let title = self.headerBarTitle {
//            self.title = title
//        } else {
//            self.title = "WKWebView"
//        }
//        self.navigationController?.setNavigationBarHidden(!showBar, animated: true)
//    }
//
//    /// To setup bottom footer bar
//    private func setupBottomToolbar(show showBar : Bool ){
//        self.navigationController?.setToolbarHidden(!showBar, animated: true)
//
//        backButton.isEnabled = false
//        forwardButton.isEnabled = false
//
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        fixedSpace.width = 20
//
//        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAction))
//
//        self.toolbarItems = [backButton, fixedSpace, forwardButton,
//                             flexibleSpace, refreshButton]
//    }
//
//    private func enableSwipeGesture(show enable : Bool){
//        /// This makes the left swipe gesture enabled even when the navigation bar / top toolbar is disabled and vis-a-vis
//        let gesture = navigationController?.interactivePopGestureRecognizer
//        if enable{
//            gesture?.isEnabled = false
//        } else {
//            gesture?.delegate = nil
//            gesture?.isEnabled = true
//        }
//    }
//
//    private func setupActivityIndicator() {
//        activityIndicator.center = self.view.center
//        activityIndicator.color = UIColor(named: "AccentColor")
//        self.view.addSubview(activityIndicator)
//   }
//
//    func updateToolBar() {
//        self.forwardButton.isEnabled = webView.canGoForward
//        self.backButton.isEnabled = webView.canGoBack
//    }
//
//    private func showDoneButton() {
//        /// only in case if presented modally
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
//        self.navigationItem.setRightBarButton(doneButton, animated: false)
//    }
//
//
//
//
//}
//
////MARK: - WKNavigation Delegate - For Webpage loadings or Navigation requests
//
//extension UIWebViewController : UIWebViewDelegate {
//
//    @available (iOS, deprecated: 12.0)
//    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//		return true
//	}
//
//    @available (iOS, deprecated: 12.0)
//	func webViewDidStartLoad(_ webView: UIWebView) {
//		activityIndicator.startAnimating()
//		updateToolBar()
//	}
//
//    @available (iOS, deprecated: 12.0)
//	func webViewDidFinishLoad(_ webView: UIWebView) {
//		hideActivityIndicator()
//	}
//
//    @available (iOS, deprecated: 12.0)
//	func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        if (error as NSError).code == NSURLErrorCancelled {
//            return
//        }
//        checkAndDisplayError(error: error)
//		hideActivityIndicator()
//	}
//
//	func hideActivityIndicator() {
//		activityIndicator.stopAnimating()
//		updateToolBar()
//	}
//
//	func checkAndDisplayError(error: Error) {
//		/// Go back to the home screen (root view controller) when it is the first webpage of webview and dismiss if it is Modal screen
//		if !webView.canGoBack {
//			displayErrorAlert(err: error, { _ in
//				if self.presentedAsModel {
//					self.dismiss(animated: true, completion: nil)
//				} else{
//					self.navigationController?.popViewController(animated: true)
//				}
//			})
//		} else{
//			displayErrorAlert(err: error, nil)
//		}
//	}
//}
//
//extension UIWebViewController {
//
//    /// Displays the error alert messages ( parameter as String )
//	func displayErrorAlert(message msg : String){
//		messageAlert(title:"Error Message", message:msg, nil)
//	}
//
//    /// Displays the error alert messages ( parameter as Error )
//	func displayErrorAlert(err error : Error,  _ action : ((UIAlertAction) -> Void)?){
//		messageAlert(title:"Error Message", message:error.localizedDescription, action)
//	}
//
//	func messageAlert(title titleStr : String, message msg : String, _ action : ((UIAlertAction) -> Void)?) {
//		let alertController = UIAlertController(title: titleStr, message: msg, preferredStyle: .alert)
//		let alerAction = UIAlertAction(title: "OK", style: .cancel, handler: action)
//		alertController.addAction(alerAction)
//		self.present(alertController, animated: true, completion: nil)
//	}
//
//}
