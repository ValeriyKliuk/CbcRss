//
//  RSSViewController.swift
//  CbcRss
//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import CoreMotion

class RSSViewController: UIViewController, RSSViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: RSSPresenterProtocol?
    
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RSSItem>>()
    
    private let motionManager = CMMotionManager()
    private var lastY = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        presenter?.getFreshAPIData()
        
        motionManager.startDeviceMotionUpdates(to: .main, withHandler:{ deviceMotion, error in
            guard let deviceMotion = deviceMotion else { return }
            guard abs(deviceMotion.rotationRate.y - self.lastY) > 0.1 else { return }
            
            let xRotationRate = CGFloat(deviceMotion.rotationRate.x)
            let yRotationRate = CGFloat(deviceMotion.rotationRate.y)
            let zRotationRate = CGFloat(deviceMotion.rotationRate.z)
            
            self.lastY = deviceMotion.rotationRate.y
            print("y \(yRotationRate) and x \(xRotationRate) and z\(zRotationRate)")
            
            if abs(yRotationRate) > (abs(xRotationRate) + abs(zRotationRate)) {
                self.tableView.reloadData()
            }
        })
        
        
        // MARK: - UITableViewDataSource
        
        self.presenter?.items
            .asDriver()
            .map { [SectionModel(model: "CBC RSS Feed", items: $0)]}
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        dataSource.configureCell = { (_, tableView, indexPath, item: RSSItem) in
            let cell: RSSTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RSSFeed", for: indexPath) as! RSSTableViewCell
            cell.configure(title: item.title, author: item.author, pubDate: item.pubDate, imgLink: item.imgLink)
            return cell
        }
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if let object = self.presenter?.items.value[indexPath.row] {
                    self.performSegue(withIdentifier: "toDetail", sender: object)
                }
            })
            .addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            switch identifier {
            case "toDetail":
                let detailViewController = segue.destination as! DetailViewController
                let item: RSSItem = sender as! RSSItem
                detailViewController.link = item.link
            default:
                break
            }
        }
        
    }

}
