//
//  RSSTableViewCell.swift
//  CbcRss
//
//  Created by Valeriy Kliuk on 2017-04-27.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RSSTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    /// configure cell
    func configure(title: String, author: String, pubDate: String, imgLink: String) {
        self.contentLabel.text = "\(title)\n\(pubDate)\n\(author)"

        DispatchQueue.global(qos: .background).async { [weak self]() -> Void in
            let url = URL(string: imgLink)!
            DispatchQueue.main.async {
                () -> Void in
                self?.customImageView?.af_setImage(withURL: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
