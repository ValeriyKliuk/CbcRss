//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RSSPresenter: RSSPresenterProtocol, RSSInteractorOutputProtocol
{
    weak var view: RSSViewProtocol?
    var interactor: RSSInteractorInputProtocol?
    var wireFrame: RSSWireFrameProtocol?
    var items: Variable<[RSSItem]> = Variable([])

    init() {}
    
    // MARK: - Input
    func getFreshAPIData() {
        interactor?.lookupForRSSItems()
    }
    
    // MARK: - Output
    func lookupResult(with items: [RSSItem]?, error: Error?) {
        
        if let items = items {
            self.items.value = items
        }
    }
}
