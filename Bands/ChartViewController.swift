//
//  ChartViewController.swift
//  Bands
//
//  Created by Gabriel Araujo on 06/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework
import SwiftSpinner

class ChartViewController: UIViewController {
    
    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var viewContainer: UIVisualEffectView! {
        didSet {
            viewContainer.clipsToBounds = true
            viewContainer.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var btnFetch: UIButton!
    @IBOutlet weak var btnReturn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NC.addObserver(self, selector: #selector(ChartViewController.changeBgImage(_:)), name: NSNotification.Name(rawValue: kChangeBgImage), object: nil)
        
        NC.addObserver(self, selector: #selector(ChartViewController.addedNewBand(_:)), name: NSNotification.Name(rawValue: kAddedBand), object: nil)
        
        self.getData()
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
    
    func addedNewBand(_ notification: Notification){
        self.getData()
    }
    
    func getData(){
        var countries:[String] = []
        var qty:[Double] = []
        SwiftSpinner.show("Getting Local Bands...")
        Band.getAll({
            result in
            switch result {
            case .success(let bands):
                bands.forEach({
                    obj in
                    if countries.count == 0 {
                        if let country = obj.country {
                            countries.append(country)
                            qty.append(1.0)
                        }
                    }else{
                        if let country = obj.country {
                            if countries.contains(country) {
                                if let index = countries.index(of: country) {
                                    qty[index] = qty[index] + 1
                                }
                            }else{
                                countries.append(country)
                                qty.append(1.0)
                            }
                        }
                    }
                })
                SwiftSpinner.hide()
                self.setChart(dataPoints: countries, values: qty)
            case .failure(let error):
                print(error) //NEEDS TO BE HANDLED
                SwiftSpinner.show("Failed to download...").addTapHandler({
                    SwiftSpinner.hide()
                }, subtitle: "Tap to hide.")
            }
        })
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        pieChart.data = nil
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Countries")
        pieChartDataSet.sliceSpace = 2.0
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let pFormatter = IntegerValueFormatter()
        pieChartData.setValueFormatter(pFormatter)
        pieChart.data = pieChartData
        pieChart.chartDescription?.text = "# of bands per country"
        
        var colors: [UIColor] = []
        
        dataPoints.forEach({ _ in
            var color = UIColor.randomFlat
            while colors.contains(color) {
                color = UIColor.randomFlat
            }
            colors.append(color)
        })
        
        pieChartDataSet.colors = colors
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnFetchTapped(_ sender: UIButton) {
        SwiftSpinner.show("We are downloading the remaining bands in background...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "Tap to close this.")
        Band.fetchAll()
    }
    
    @IBAction func btnReturnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
