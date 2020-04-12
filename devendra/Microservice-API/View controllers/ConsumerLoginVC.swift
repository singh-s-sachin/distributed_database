//
//  ConsumerLoginVC.swift
//  Microservice-API
//
//  Created by Sachin Kumar Singh on 13/03/20.
//  Copyright © 2020 Sachin Kumar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ConsumerLoginVC: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var headline: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headline.text="Consumer Login"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginbtnpressed(_ sender: Any) {
        let user=username.text
        let pwd=password.text
        let k=user!+":"+pwd! as NSString
        let body=["username":user,"password":pwd]
        let credentialData = k.data(using: String.Encoding.utf8.rawValue)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        let apilink="http://127.0.0.1:5000/\(user ?? "ola")/login"
        print(apilink)
        let defaults = UserDefaults.standard
        Alamofire.request(apilink, method: .post ,parameters: body as Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {(response) in
                    guard let data = response.data else { return }
                    do{
                        let json = try JSON(data: data)
                        let outputcode = json["token"].stringValue
                        print(outputcode)
                        defaults.set(outputcode,forKey: "consumertoken")
                        defaults.set(user,forKey: "appname")
                        self.performSegue(withIdentifier: "toapp", sender: nil)
                    }
                    catch{
                        debugPrint(error)
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
}
