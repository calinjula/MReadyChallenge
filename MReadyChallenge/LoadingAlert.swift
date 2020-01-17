import UIKit

class LoadingAlert {
    
    static var loadingAlert: UIViewController {
        let alert = UIAlertController(title: "Loading Data", message: nil, preferredStyle: .alert)
        let activitySpinner = UIActivityIndicatorView(style: .large)
        activitySpinner.startAnimating()
        alert.view.addSubview(activitySpinner)
        activitySpinner.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor).isActive = true
        return alert
    }
}
