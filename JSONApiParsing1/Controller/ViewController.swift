//
//  ViewController.swift
//  JSONApiParsing1
//
//  Created by NTS on 05/01/24.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var asumeLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    var manager = ApiManager()
    let nc = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        idTextField.delegate = self
        nc.delegate = self
    }
    
    @IBAction func getIdButtonPressed(_ sender: UIButton) {
        idTextField.endEditing(true)
        let secondVC = storyboard?.instantiateViewController(identifier: "ResultViewController") as? ResultViewController
        self.navigationController?.pushViewController(secondVC!, animated: true)
    }
    
}

extension ViewController: DataManagerDelegate
{
    func didDisplayData(_ apiManager: ApiManager, apiDataCondition: ApiDataConditions) {
        DispatchQueue.main.async {
            self.asumeLabel.text = apiDataCondition.title
        }
    }
}

extension ViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if idTextField.text != nil {
            return true
        }else {
            idTextField.placeholder = "Enter ID here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let id = idTextField.text {
            manager.fetchData(id: Int(id)!)
        }
        idTextField.text = ""
    }
}

