//
//  HomeViewController.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import UIKit
import ChameleonFramework

class HomeViewController: UIViewController {

    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var topBar: UIVisualEffectView!
    @IBOutlet weak var btnGraph: UIButton!
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var bands:[Band] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewBg.image = currentBgImage
        // Do any additional setup after loading the view, typically from a nib.
        
        NC.addObserver(self, selector: #selector(HomeViewController.changeBgImage(_:)), name: NSNotification.Name(rawValue: kChangeBgImage), object: nil)
        
        Band.getFromFile(completion: {
            result in
            switch result {
            case .success(let bands):
                self.bands = bands
                self.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeBgImage(_ notification: Notification){
        UIView.transition(with: self.imgViewBg, duration:2, options: .transitionCrossDissolve, animations: {
            self.imgViewBg.image = currentBgImage
        },completion: nil)
    }

}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BandCell") as! BandCell
        
        let selectedColor = UIColor.randomFlat
        let band = self.bands[indexPath.row]
        if let name = band.name {
            cell.lblName.text = name
        }
        cell.color = selectedColor
        cell.bullet.backgroundColor = selectedColor
        
        return cell
    }
}

extension HomeViewController : UITableViewDelegate {
    
}