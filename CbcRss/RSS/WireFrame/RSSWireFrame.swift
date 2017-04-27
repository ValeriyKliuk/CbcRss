//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation

class RSSWireFrame: RSSWireFrameProtocol
{
    class func assembleRSSModule(with viewController: RSSViewController)
    {
        // Generating module components
        let presenter: RSSPresenterProtocol & RSSInteractorOutputProtocol = RSSPresenter()
        let interactor: RSSInteractorInputProtocol = RSSInteractor()
        let APIDataManager: RSSAPIDataManagerInputProtocol = RSSAPIDataManager()
        let wireFrame: RSSWireFrameProtocol = RSSWireFrame()
        
        // Connecting
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
    }
}
