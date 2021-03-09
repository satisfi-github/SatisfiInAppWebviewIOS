//
//  WebView.swift
//  WebView_SatisfiLabs
//
//  Created by Vinay Bharwani on 2/7/21.
//

import Foundation

//MARK: - This model is created just for User Defaults

enum WebViewType: String {
    case wKWebView = "WKWebView"
    case safariView = "SafariView"
}

//Review comment
//Redesigning the above class for better readability, safety and scalability

struct WebView {
    
    static let shared = WebView()
    private init() {}
    
    var baseUrlString: String? {
        get {
            return UserDefaults.standard.value(forKey: "baseUrlString") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "baseUrlString")
            UserDefaults.standard.synchronize()
        }
    }
    
    var paramUrlString: String? {
        get {
            return UserDefaults.standard.value(forKey: "paramUrlString") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "paramUrlString")
            UserDefaults.standard.synchronize()
        }
    }
    var finalUrlString: String? {
        get {
            return UserDefaults.standard.value(forKey: "finalUrlString") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalUrlString")
            UserDefaults.standard.synchronize()
        }
    }
    
    var type: WebViewType {
        get {
            if let type = UserDefaults.standard.value(forKey: "type") as? String {
                return WebViewType(rawValue: type) ?? .wKWebView
            }
            else {
                return .wKWebView
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "type")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isModal: Bool {
        get {
            return UserDefaults.standard.value(forKey: "isModal") as? Bool ?? false
            //False is the default value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isModal")
            UserDefaults.standard.synchronize()
        }
    }
    
    var showTopbar: Bool {
        get {
            return UserDefaults.standard.value(forKey: "showTopbar") as? Bool ?? true
            //True is the default value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "showTopbar")
            UserDefaults.standard.synchronize()
        }
    }
    
    var showBottombar: Bool {
        get {
            return UserDefaults.standard.value(forKey: "showBottombar") as? Bool ?? false
            //False is the default value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "showBottombar")
            UserDefaults.standard.synchronize()
        }
    }
    
}
