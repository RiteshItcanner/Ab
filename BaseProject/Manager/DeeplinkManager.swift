//
//  DeeplinkManager.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 22/05/24.
//

import FirebaseDynamicLinks
import Foundation

class DeeplinkManager: NSObject {
    static let shared = DeeplinkManager()
    var refferalID: String?
    private var queryParameters: [String: Any]? = nil

    private func urlComponenet(_ url: URL) -> URLComponents? {
        guard let components = URLComponents(string: url.absoluteString) else { return nil }
        return URLComponents(string: url.absoluteString)
    }

    private func urlQueryParamters(_ components: URLComponents) -> [String: Any] {
        var parameters: [String: Any] = [:]
        components.queryItems?.forEach({ item in
            parameters[item.name] = item.value
        })
        return parameters
    }

    func handle(deepLinkURL url: URL?) {
//        guard let url = url else {
//            return
//        }
//
//        if DeeplinkManager.isDeepLinkURL(url: url) {
//            guard let components = urlComponenet(url) else { return }
//            if let rootVC = PreConfigConstant.rootcontroller {
//                switch components.host {
//                case "mooninf.page.link":
//                    let queryParameters = urlQueryParamters(components)
//                    if let id = queryParameters["referral"] as? String {
//                        refferalID = id
//                        Contact.shared.updateRefferalCountById(id)
//                    } else if components.url?.lastPathComponent == "moonapp" {
//                        openHomeScreen(rootVC)
//                    }
//                case "moon.influencer.ae":
//                    let queryParameters = urlQueryParamters(components)
//                    self.queryParameters = queryParameters
//                default:
//                    break
//                }
//            }
//        }
    }

    class func isDeepLinkURL(url: URL!) -> Bool! {
        let domainToCheck = ["moonapp", "mooninf", "moon.influencer.ae"]
        for domain in domainToCheck {
            if url.absoluteString.lowercased().contains(domain) {
                return true
            }
        }
        return false
    }

    func getUTMParameters() -> [String: Any]? {
        return queryParameters
    }

    private func openHomeScreen(_ rootVC: UIViewController) {
//        if let nav = rootVC as? AppNavigationController {
//            let presentedVc = PreConfigConstant.findPresentedViewController(rootVC)
//            presentedVc.dismiss(animated: true)
//            nav.popToRootViewController(animated: true)
//            let notificationInfo = ["tabIndex": 0]
//            NotificationCenter.default.post(name: Notification.Name(NotificationKey.tabSwtichNotification),
//                                            object: nil,
//                                            userInfo: notificationInfo)
//        }
    }
}

