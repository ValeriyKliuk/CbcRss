//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation

class RSSInteractor: RSSInteractorInputProtocol
{
    weak var presenter: RSSInteractorOutputProtocol?
    var APIDataManager: RSSAPIDataManagerInputProtocol?
    
    init() {}
    
    // MARK: - Search
    func lookupForRSSItems() {
        let apiManager = RSSAPIDataManager()
        apiManager.lookupForRSSItems { (items, error) in
            self.presenter?.lookupResult(with: items, error: error)
        }
    }
}
