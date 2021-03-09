//
//  HomeTableViewController.swift
//  WebView_SatisfiLabs
//
//  Created by Vinay Bharwani on 2/26/21.
//

import UIKit

//
// MARK: - HomeUrl View Controller
//
class HomeUrlVC: UITableViewController {
    //
    //    MARK: - Outlets
    //
    @IBOutlet weak var baseUrlTextField: UITextField!
    @IBOutlet weak var urlParamsTextField: UITextField!
    
    @IBOutlet weak var finalUrlLabel: UILabel!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    @IBOutlet weak var presentModalSwitch: UISwitch!
    @IBOutlet weak var showHeaderBarSwitch: UISwitch!
    @IBOutlet weak var showFooterBarSwitch: UISwitch!
    
    //
    //    MARK: - Properties
    //
    /// WebView model object
    var webview = WebView.shared
    
    //
    //    MARK: - Actions
    //
    @IBAction func wkWebviewTapped(_ sender: UIButton) {

        /// Checks whether the URL string is empty
        if finalUrlLabel.text != "" {
            validateAndMove(webViewType: .wKWebView)
        } else{
            displayErrorMessage(errorMsg: Messages.emptyURL)
        }
        
    }
    
    @IBAction func safariViewTapped(_ sender: Any) {
        
        /// Checks whether the URL string is empty
        if finalUrlLabel.text != "" {
            validateAndMove(webViewType: .safariView)
        } else {
            displayErrorMessage(errorMsg: Messages.emptyURL)
        }
        
    }
    
    @IBAction func headerBarToggled(_ sender: Any) {
        if !showHeaderBarSwitch.isOn{
            displayErrorAlert(message: Messages.topbarOffAlert)
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        errorMsgLabel.isHidden = true

        formURLWhileAdjustingQuestionMark()
    }


    //
    //    MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Toggle buttons initial settings
        presentModalSwitch.setOn(webview.isModal, animated: true)
        showHeaderBarSwitch.setOn(webview.showTopbar, animated: true)
        showFooterBarSwitch.setOn(webview.showBottombar, animated: true)
        
        
        /// Display last urls from user defaults if any
        baseUrlTextField.text = webview.baseUrlString
        urlParamsTextField.text = webview.paramUrlString
        finalUrlLabel.text = webview.finalUrlString
        
        errorMsgLabel.isHidden = true
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// Hiding the topbar and bottombar of Home screen after navigating back from Webview screens
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    //
    // MARK: - Functions
    //
    /// This is called when any of the button is pressed which further checks the URL validation and takes the user to the next screen
    func validateAndMove(webViewType type : WebViewType){
        let stringURL = finalUrlLabel.text ?? ""
        
        /// Checks whether the entered URL string is valid or not
        if isValidURLString(urlString : stringURL){
            
            /// URL string, Webview type, Topbar and Bottombar toggle status updated to user defaults
            webview.baseUrlString = baseUrlTextField.text
            webview.paramUrlString = urlParamsTextField.text
            webview.finalUrlString = finalUrlLabel.text
            webview.type = type
            webview.isModal = presentModalSwitch.isOn
            webview.showTopbar = showHeaderBarSwitch.isOn
            webview.showBottombar = showFooterBarSwitch.isOn
            
            /// Move the Webview page based on the user selection
            goToSelectedWebView(isModal: presentModalSwitch.isOn)

        } else{
            displayErrorMessage(errorMsg: Messages.invalidURL)
        }
    }
    
    /// Move the Webview page based on the user selection
    func goToSelectedWebView(isModal presentModally : Bool){
        
        
        let selectedWebView = webview.type
        
        /// Check the type of webview selected and move accordingly
        switch selectedWebView{
        
        case .wKWebView :
            if let urlString = finalUrlLabel.text{
                let wkWebView = WKWebViewController(with: urlString)
                wkWebView.headerBarTitle = "Chatbot"  // optional (not necessary)
                wkWebView.showHeaderBar = webview.showTopbar
                wkWebView.showFooterBar = webview.showBottombar
                
                if presentModally{
                    let navC = UINavigationController(rootViewController: wkWebView)
                    self.present(navC, animated: true, completion: nil)
                } else{
                    self.navigationController?.pushViewController(wkWebView, animated: true)
                }
            }

            break
        
        case .safariView :
            if let urlString = finalUrlLabel.text{
                let urlStr = urlString.hasPrefix("https://") || urlString.hasPrefix("http://") ? urlString : "http://" + urlString
                if let url = URL(string: urlStr) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    /// Displays the error message on invalid or empty URL
    func displayErrorMessage(errorMsg msg : String){
        errorMsgLabel.isHidden = false
        errorMsgLabel.text = msg
        baseUrlTextField.shake()
    }
    
    /// Checks the validation of string URL and return true or false
    func isValidURLString(urlString urlStr: String) -> Bool {
        
        /// Checking result of string as link
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && urlStr.count > 0) else { return false }
        
        /// Checks if the first character of the string is a special character or not
        let alphaNum = CharacterSet.alphanumerics
        let firstCharIsSpecial = urlStr.prefix(1).rangeOfCharacter(from: alphaNum) == nil
        
        /// Matching rules using regular expressions
        if (detector!.numberOfMatches(in: urlStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, urlStr.count)) > 0) && !firstCharIsSpecial{
            return true
        }
        return false
    }
    
    /// This adds the "?" symbol in URL if it is not there before url parameters
    func formURLWhileAdjustingQuestionMark(){
        let baseURL = "chat.satis.fi/"
        let baseURLTest = "chat.satisfitest.us/"
        
        if let baseUrl = baseUrlTextField.text, let urlParams = urlParamsTextField.text {
            let urlString = baseUrl + urlParams
            
            /// This adds question mark only when the URL contains either of the baseURLs
            if urlString.contains(baseURL) || urlString.contains(baseURLTest){
                if urlString.contains("?"){
                    finalUrlLabel.text = urlString
                } else{
                    if let range = urlString.range(of: ".fi/") {
                        let afterSlash = urlString[range.upperBound...]
                        finalUrlLabel.text = "https://" + baseURL + "?" + afterSlash
                    }
                    else if let range = urlString.range(of: ".us/") {
                        let afterSlash = urlString[range.upperBound...]
                        finalUrlLabel.text = "https://" + baseURLTest + "?" + afterSlash
                    }
                }
            } else{
                finalUrlLabel.text = urlString
            }
            
        }
    }

    /// Displays the error alert message
    func displayErrorAlert(message msg : String){
        messageAlert(title:"Warning", message:msg, nil)
    }
    
    func messageAlert(title titleStr : String, message msg : String, _ action : ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: titleStr, message: msg, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: "OK", style: .cancel, handler: action)
        alertController.addAction(alerAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
