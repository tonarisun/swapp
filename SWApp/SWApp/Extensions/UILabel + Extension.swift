//
// SWApp
//
// UILabel + Extension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

extension UILabel {
    func setSpacedText(_ text: String?,
                       color: UIColor = .white,
                       alignment: NSTextAlignment = .left) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineHeightMultiple = 1.34
        let attributedText = NSAttributedString(string: text ?? "",
                                                attributes: [.font: font as Any,
                                                             .foregroundColor: color,
                                                             .paragraphStyle: paragraphStyle])
        self.attributedText = attributedText
    }
}
