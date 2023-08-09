//
// SWApp
//
// FilmInfoTableCell
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class FilmInfoTableCell: UITableViewCell {
    static let identifier = "FilmInfoTableCell"
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(infoLabel)
        infoLabel.setConstraints([.topToTop(10), .rightToRight(10), .bottomToBottom(10), .leftToLeft(10)], to: contentView)
    }
    
    func construct(model: FilmInfoModel) {
        infoLabel.text = model.info
    }
}
