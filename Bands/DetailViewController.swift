//
//  DetailViewController.swift
//  Bands
//
//  Created by Gabriel Araujo on 04/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import UIKit
import ChameleonFramework
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGenre: UILabel! {
        didSet {
            lblGenre.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var imgViewCountry: UIImageView!
    @IBOutlet weak var lblCountry: UILabel! {
        didSet {
            lblCountry.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var btnWebsite: UIButton!
    
    var receivingColor:UIColor!
    var receivingBand:Band!
    
    //Flag
    var flagGradientApplied = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setValues(){
        self.backButton.backgroundColor = self.receivingColor
        self.lblGenre.text = self.receivingBand.genre
        self.lblCountry.text = self.receivingBand.country
        self.lblName.text = self.receivingBand.name
        if let imgCountry = URL(string: self.receivingBand.countryFlagUrl!) {
            self.imgViewCountry.kf.indicatorType = .activity
            self.imgViewCountry.kf.setImage(with: imgCountry, options: [.transition(.fade(0.2))])
        }
        if let imgLogo = URL(string: self.receivingBand.imageUrl!) {
            self.coverImageView.contentMode = .scaleToFill
            self.coverImageView.kf.indicatorType = .activity
            self.coverImageView.kf.setImage(with: imgLogo, completionHandler: {
                image, error, cacheType, imageUrl in
                if let img = image {
                    if !bgImagesId.contains(self.receivingBand.id!) {
                        bgImages.append(img)
                        bgImagesId.append(self.receivingBand.id!)
                    }
                }else{
                    self.coverImageView.contentMode = .scaleAspectFit
                    self.coverImageView.image = UIImage(named: "sad")
                }
            })
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnWebsiteTapped(_ sender: UIButton) {
    }
    

}
