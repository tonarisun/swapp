//
// SWApp
//
// UIView + Extension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

extension UIView {
    enum Constraint {
        case topToTop(_ value: Double = 0.0)
        case topToBottom(_ value: Double = 0.0)
        case bottomToTop(_ value: Double = 0.0)
        case bottomToBottom(_ value: Double = 0.0)
        case leftToLeft(_ value: Double = 0.0)
        case leftToRight(_ value: Double = 0.0)
        case rightToLeft(_ value: Double = 0.0)
        case rightToRight(_ value: Double = 0.0)
        case width(_ value: Double = 0.0)
        case height(_ value: Double = 0.0)
        case centerX(_ value: Double = 0.0)
        case centerY(_ value: Double = 0.0)
    }
    
    func setConstraints(_ constraints: [Constraint], to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { constraint in
            switch constraint {
            case .topToTop(let value):
                self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: value).isActive = true
            case .topToBottom(let value):
                self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: value).isActive = true
            case .bottomToTop(let value):
                self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: value).isActive = true
            case .bottomToBottom(let value):
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: value).isActive = true
            case .leftToLeft(let value):
                self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: value).isActive = true
            case .leftToRight(let value):
                self.leftAnchor.constraint(equalTo: view.rightAnchor, constant: value).isActive = true
            case .rightToLeft(let value):
                self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: value).isActive = true
            case .rightToRight(let value):
                self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: value).isActive = true
            case .width(let value):
                self.widthAnchor.constraint(equalToConstant: value).isActive = true
            case .height(let value):
                self.heightAnchor.constraint(equalToConstant: value).isActive = true
            case .centerX(let value):
                self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: value).isActive = true
            case .centerY(let value):
                self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: value).isActive = true
            }
        }
    }
}
