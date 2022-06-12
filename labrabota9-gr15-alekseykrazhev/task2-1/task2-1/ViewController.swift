//
//  ViewController.swift
//  task2-1
//
//  Created by Кражевский Алексей И. on 6/8/22.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var loginL: UITextField!
    @IBOutlet weak var passL: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var loginR: UITextField!
    @IBOutlet weak var mailR: UITextField!
    @IBOutlet weak var passR: UITextField!
    @IBOutlet weak var c_passR: UITextField!
    @IBOutlet weak var errorR: UILabel!
    @IBOutlet weak var errorL: UILabel!
    @IBOutlet weak var terms: UISwitch!
    var isLoggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.isHidden = true
        isLoggedIn = false
    }

    @IBAction func signIn(_ sender: Any) {
        if (loginL.text!.isEmpty || passL.text!.isEmpty) {
            errorL.text = "Smth is missing..."
            return
        }
        UserDefaults.standard.set(loginL.text, forKey: "login")
        UserDefaults.standard.set(passL.text, forKey: "pass")
        isLoggedIn = true
        performSegue(withIdentifier: "toParks", sender: self)
        //self.reloadInputViews()
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUpView.isHidden = false
        errorL.isHidden = true
    }
    
    @IBAction func signInR(_ sender: Any) {
        signUpView.isHidden = true
        errorL.isHidden = false
        
    }
    
    @IBAction func signUpR(_ sender: Any) {
        if (loginR.text!.isEmpty || passR.text!.isEmpty || mailR.text!.isEmpty || c_passR.text!.isEmpty) {
            errorR.text = "Some info is missing!"
            return
        }
        
        if (passR.text != c_passR.text) {
            errorL.text = "Passwords don't match!"
            return
        }
        
        if ((terms == nil)){
            errorL.text = "Agree with terms!"
            return
        }
        
        UserDefaults.standard.set(loginL.text, forKey: "login")
        UserDefaults.standard.set(passL.text, forKey: "pass")
        UserDefaults.standard.set(mailR.text, forKey: "mail")
        isLoggedIn = true
        performSegue(withIdentifier: "toParks", sender: self)
    }

    
}


class ParkCell: UICollectionViewCell{
    
    @IBOutlet weak var name: UILabel!
    
    
}


class NewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var list = NSDictionary();
    @IBOutlet var pictureField: UIImageView!
    @IBOutlet var descriptionField: UITextView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ParkCell
        
        cell.name.text=((list.allKeys ) [indexPath.row] as! String);
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let courseInfo = (list.object(forKey: ((list.allKeys ) [indexPath.row]))) as! NSDictionary;
        
        //NSLog(courseInfo.description)
       
        descriptionField.text = NSLocalizedString(courseInfo.object(forKey: "Description") as! String, comment: "Some comment");
        let image: UIImage = UIImage(named: courseInfo.object(forKey: "Icon") as! String)!
        pictureField = UIImageView(image: image)
        pictureField.frame = CGRect(x: 0, y: 600, width: 500, height: 252)
        view.addSubview(pictureField)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let filePath = Bundle.main.path(forResource: "myData", ofType: "plist")
        list = NSDictionary(contentsOfFile:filePath!)!
        //NSLog(list.description)
    }
    
}
