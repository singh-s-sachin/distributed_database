//
//  adduserVC.swift
//  Microservice-API
//
//  Created by Sachin Kumar Singh on 13/03/20.
//  Copyright © 2020 Sachin Kumar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class adduserVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createuserbtnpressed(_ sender: Any) {
        let user=username.text
        let pwd=password.text
        let defaults = UserDefaults.standard
            let token=defaults.string(forKey: "consumertoken") ?? "qwetyuiuyfc"
            let headers = ["x-access-token": token]
            let apilink="http://127.0.0.1:5000/\(defaults.string(forKey: "appname") ?? "ola")/register"
            let body : [String : String] = ["name":user ?? "nil","password":pwd ?? "nil"]
            Alamofire.request(apilink, method: .post , parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON
                {(response) in
                    guard response.data != nil else { return }
                        do{
                            self.performSegue(withIdentifier: "back", sender: nil)
                        }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

