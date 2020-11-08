//
//  StocksViewController.swift
//  HackPSU3
//
//  Created by Shahzeb Ahmed on 11/8/20.
//

import UIKit
import Firebase
import FirebaseUI

class StocksViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var stockSearchBar: UITextField!
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    
    
    var currentTicker: String = "MSFT"
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockSearchBar.placeholder = "Type ticker symbol"
        // Do any additional setup after loading the view.
        stockSearchBar.delegate = self
        stockPriceLabel.adjustsFontSizeToFitWidth = true
        stockPriceLabel.minimumScaleFactor = 0.01
    }
    func makeStockRequest(ticker: String){
    var baseURL = "https://desolate-mesa-26133.herokuapp.com/" + ticker
        let urlToPass = URL(string: baseURL)
        currentTicker = ticker
        let task = URLSession.shared.dataTask(with: urlToPass!) { (data, response, error) in
            if let error = error{
                
                print(error.localizedDescription)
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                var currencyAmount = dataString.dropFirst()
                currencyAmount = currencyAmount.dropLast()

                DispatchQueue.main.async{
                    self.stockPriceLabel.text = ticker + ": $" + currencyAmount
                }

                }
        }//datatask
       
        task.resume()
    }//makeStockRequest

    func compareStock(ticker: String){
    var baseURL = "https://desolate-mesa-26133.herokuapp.com/compare/" + ticker
        let urlToPass = URL(string: baseURL)
        
        let task = URLSession.shared.dataTask(with: urlToPass!) { (data, response, error) in
            if let error = error{
                
                print(error.localizedDescription)
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")

                DispatchQueue.main.async{
                    self.stockPriceLabel.text = ticker + ": " + dataString + "% Change"
                }

                }
        }//datatask
       
        task.resume()
    }//makeStockRequest
    
    
    @IBAction func percentChangedAction(_ sender: Any) {
        compareStock(ticker: currentTicker)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        makeStockRequest(ticker: currentTicker)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var ticker = stockSearchBar.text
        stockSearchBar.endEditing(true)
        return (true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text{
            makeStockRequest(ticker: text)
        }
        
        stockSearchBar.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if stockSearchBar.text != ""{
            return true
        }else{
        stockSearchBar.placeholder = "Type ticker symbol"
        return false
        }//else
    }//textfieldshouldendediting
    
    
}
