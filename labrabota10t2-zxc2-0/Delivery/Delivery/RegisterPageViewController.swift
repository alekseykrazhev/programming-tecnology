import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        if(userName!.isEmpty || userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty) {
            displayMyAlertMessage(userMesagge: "No empty fields!")
            return;
        }
        
        if(userPassword != userRepeatPassword) {
            displayMyAlertMessage(userMesagge: "Passwords do not match")
            return;
        }
        
        //Store data
        UserDefaults.standard.set(userName, forKey:"userName")
        UserDefaults.standard.set(userEmail, forKey:"userEmail")
        UserDefaults.standard.set(userPassword, forKey:"userPassword")
        UserDefaults.standard.synchronize()
        
        // CONFIRM
        var myAlert = UIAlertController(title:"Alert", message: "Registration is successfull", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){ action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    func displayMyAlertMessage(userMesagge:String) {
        var myAlert = UIAlertController(title:"Alert", message: userMesagge, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
}
