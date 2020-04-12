//
//  addapp.swift
//  Microservice-API
//
//  Created by Sachin Kumar Singh on 02/02/20.
//  Copyright © 2020 Sachin Kumar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class addapp: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var appname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addpostpressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        let token=defaults.string(forKey: "token") ?? "qwetyuiuyfc"
        let headers = ["x-access-token": token]
        let apilink="http://127.0.0.1:5000/app"
        let app=appname.text
        let pwd=password.text
        let body : [String : String] = ["name":app ?? "nil","password":pwd ?? "nil"]
        Alamofire.request(apilink, method: .post , parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON
            {(response) in
                    guard let data = response.data else { return }
                    do{
                        //let json = try JSON(data: data)
                        self.performSegue(withIdentifier: "back", sender: nil)
                    }
                    catch{
                        debugPrint(error)
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

}
