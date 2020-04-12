//
//  LoginVC.swift
//  Microservice-API
//
//  Created by Sachin Kumar Singh on 29/01/20.
//  Copyright © 2020 Sachin Kumar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func consumerLoginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "consumerlogin", sender: nil)
    }
    @IBAction func accessBtnPressed(_ sender: Any) {
        let user=username.text
        let pwd=password.text
        let k=user!+":"+pwd! as NSString
        let credentialData = k.data(using: String.Encoding.utf8.rawValue)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        let apilink="http://127.0.0.1:5000/login"
        let defaults = UserDefaults.standard
        Alamofire.request(apilink, method: .get , encoding: JSONEncoding.default, headers: headers).responseJSON
            {(response) in
                    guard let data = response.data else { return }
                    do{
                        let json = try JSON(data: data)
                        let outputcode = json["token"].stringValue
                        defaults.set(outputcode,forKey: "token")
                        self.performSegue(withIdentifier: "item", sender: nil)
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
