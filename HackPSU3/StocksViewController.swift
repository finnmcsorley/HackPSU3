//
//  StocksViewController.swift
//  HackPSU3
//
//  Created by Shahzeb Ahmed on 11/8/20.
//

import UIKit
import Firebase
import FirebaseUI

class StocksViewController: UIViewController {
    
    
    
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    
    
    
    var stockValue: String {
        get{
            return self.stockValue
        }
        set{
            print("just set stock value")
            stockPriceLabel.text = stockValue
        }
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeStockRequest()
    }
    func makeStockRequest(){
        let urlToPass = URL(string: "https://desolate-mesa-26133.herokuapp.com/ibm")
        
        let task = URLSession.shared.dataTask(with: urlToPass!) { (data, response, error) in
            if let error = error{
                
                print(error.localizedDescription)
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                print(dataString)
                self.stockValue = dataString

                }
        }//datatask
       
        task.resume()
    }//makeStockRequest

    
    
    
    
}
