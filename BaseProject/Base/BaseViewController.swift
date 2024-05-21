//
//  BaseViewController.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 17/05/24.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    
    var reachability: Reachability?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBar()
        setupUI()
        setupReachability()
    }
    
    // MARK: - UI Setup
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Loaders/Indicators
    
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.tag = 999
        view.addSubview(activityIndicator)
    }
    
    func hideLoadingIndicator() {
        if let activityIndicator = view.viewWithTag(999) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    // MARK: - Logging
    
    func logMessage(_ message: String, level: LogLevel = .info) {
        switch level {
        case .debug: print("DEBUG: \(message)")
        case .info: print("INFO: \(message)")
        case .warning: print("WARNING: \(message)")
        case .error: print("ERROR: \(message)")
        }
    }
    
    enum LogLevel { case debug, info, warning, error }
    
    func showError(_ message: String, title: String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    // MARK: - Reachability
    
    private func setupReachability() {
        do {
            reachability = try Reachability()
            try reachability?.startNotifier()
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        } catch { print("Unable to start notifier") }
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        switch reachability.connection {
        case .wifi: print("Reachable via WiFi")
        case .cellular: print("Reachable via Cellular")
        case .unavailable: print("Network not reachable")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    // MARK: - Keyboard Management
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            // Adjust your UI here
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Adjust your UI here
    }
    
    // MARK: - Navigation
    
    func navigateToViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentViewController(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func dismissViewController() {
        dismiss(animated: true)
    }
    
    // MARK: - User Defaults
    
    func saveToUserDefaults(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getFromUserDefaults(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    // MARK: - Analytics
    
    func trackScreenView(screenName: String) {
        print("Tracking screen view: \(screenName)")
        // Example usage:
        AnalyticsManager.shared.trackEvent(name: "ButtonClicked", parameters: ["ButtonName": "Submit"])
    }
    
    func trackEvent(name: String, parameters: [String: Any]? = nil) {
        print("Tracking event: \(name) with parameters: \(String(describing: parameters))")
    }
    
    // MARK: - Theme Management
    
    func applyTheme() {
        view.backgroundColor = Theme.current.backgroundColor
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBarColor
        navigationController?.navigationBar.tintColor = Theme.current.tintColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.current.titleTextColor]
    }
    
    struct Theme {
        static let current = Theme()
        let backgroundColor: UIColor = .white
        let navigationBarColor: UIColor = .systemBlue
        let tintColor: UIColor = .white
        let titleTextColor: UIColor = .white
    }
}
