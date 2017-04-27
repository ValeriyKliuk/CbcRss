//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

class RSSAPIDataManager: RSSAPIDataManagerInputProtocol
{
    init() {}
    
    func lookupForRSSItems(completion: @escaping ([RSSItem]?, Error?) -> Void) {
        Alamofire.request(Helper.shared.requestLink)
            .validate(statusCode: 200..<300)
            .responseData { response in
                // Custom validation
                switch response.result {
                case .success:
                    if let data = response.data {
                        let xml = XML.parse(data)
                        var items: [RSSItem] = []
                        for item in xml["rss", "channel", "item"] {
                            // Create a new RSS Item
                            let i = RSSItem(title: item["title"].text!,
                                            author: item["author"].text!,
                                            pubDate: item["pubDate"].text!,
                                            imgLink: Utils.getImageURL(string: item["description"].text!, start: "<img src='", end: ".jpg"),
                                            link: item["link"].text!)
                            // add item to array
                            items.append(i)
                        }
                        completion(items, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
