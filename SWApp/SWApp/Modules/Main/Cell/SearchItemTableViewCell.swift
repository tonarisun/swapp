//
// SWApp
//
// SearchItemTableViewCell
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {
    static var identifier = "SearchItemTableViewCell"
    var model: SearchItemModel?
    // MARK: - UI
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let favButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Construct
    func construct(withModel model: SearchItemModel) {
        self.model = model
        descriptionLabel.text = model.description
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        selectionStyle = .none
        contentView.addSubview(descriptionLabel)
        descriptionLabel.setConstraints([.topToTop(10), .bottomToBottom(-10), .leftToLeft(10), .rightToRight(-50)], to: contentView)
        
        contentView.addSubview(favButton)
        favButton.setConstraints([.centerY(), .rightToRight(-10), .width(30), .height(30)], to: contentView)
        favButton.tintColor = .red
        favButton.setImage(UIImage(systemName: model!.isFavorite ? "heart.fill" : "heart"), for: .normal)
    }
}
