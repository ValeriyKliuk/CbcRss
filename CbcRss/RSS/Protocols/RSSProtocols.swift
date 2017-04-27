//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RSSViewProtocol: class
{
    var presenter: RSSPresenterProtocol? { get set }
    ///
    /// Add here your methods for communication PRESENTER -> VIEW
    ///
}

protocol RSSWireFrameProtocol: class
{
    static func assembleRSSModule(with viewController: RSSViewController)
    ///
    /// Add here your methods for communication PRESENTER -> WIREFRAME
    ///
}

protocol RSSPresenterProtocol: class
{
    var view: RSSViewProtocol? { get set }
    var interactor: RSSInteractorInputProtocol? { get set }
    var wireFrame: RSSWireFrameProtocol? { get set }
    var items: Variable<[RSSItem]> { get set }

    ///
    /// Add here your methods for communication VIEW -> PRESENTER
    ///
    
    // MARK: - PRESENTER methods
    
    /// get fresh API data
    func getFreshAPIData()
}

protocol RSSInteractorOutputProtocol: class
{
    ///
    /// Add here your methods for communication INTERACTOR -> PRESENTER
    ///
    
    // MARK: - INTERACTOR Output methods
    
    /// got lookup result
    func lookupResult(with items: [RSSItem]?, error: Error?)
}

protocol RSSInteractorInputProtocol: class
{
    var presenter: RSSInteractorOutputProtocol? { get set }
    var APIDataManager: RSSAPIDataManagerInputProtocol? { get set }
    ///
    /// Add here your methods for communication PRESENTER -> INTERACTOR
    ///
    
    // MARK: - INTERACTOR Input methods
    
    /// lookup for RSS Items
    func lookupForRSSItems()
}

protocol RSSAPIDataManagerInputProtocol: class
{
    ///
    /// Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    ///
    
    // MARK: - RSS API Input methods
    
    /// lookup for RSS Items
    func lookupForRSSItems(completion: @escaping ([RSSItem]?, Error?) -> Void)
}
