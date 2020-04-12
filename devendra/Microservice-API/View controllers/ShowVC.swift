//
//  ShowVC.swift
//  Microservice-API
//
//  Created by Sachin Kumar Singh on 30/01/20.
//  Copyright © 2020 Sachin Kumar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct app {
    let name : String
}
class ShowVC: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var content: UITableView!
    var apps = [app]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("abc")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tbc
        print(cell)
        cell.labelview.text = apps[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.apps[sourceIndexPath.row]
        apps.remove(at: sourceIndexPath.row)
        apps.insert(movedObject, at: destinationIndexPath.row)
    }
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token=defaults.string(forKey: "token") ?? "qwetyuiuyfc"
        let headers = ["x-access-token": token]
        let apilink="http://127.0.0.1:5000/app"
        Alamofire.request(apilink, method: .get , encoding: JSONEncoding.default, headers: headers).responseJSON
            {(response) in
                    guard let data = response.data else { return }
                    do{
                        let json = try JSON(data: data)
                        let outputcode = json["apps"]
                        var m=0
                        for _ in outputcode
                        {
                            var d = outputcode[m]["name"]
                            self.apps.insert(app(name: d.stringValue), at: 0)
                            m+=1
                        }
                    }
                    catch{
                        debugPrint(error)
                    }
                self.content.reloadData()
        }

    }

    @IBAction func addbtnpressed(_ sender: Any) {
        performSegue(withIdentifier: "addapp", sender: nil)
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
