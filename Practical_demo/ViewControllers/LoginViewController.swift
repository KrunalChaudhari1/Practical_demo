

import CoreData
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var PasswordTextFiled: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var LoginButton: UIButton!
    @IBOutlet var signUpBtn: UIButton!

    var age = ""
    var phone = ""
    var email = ""
    var password = ""

    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginButton.ToRound()
        signUpBtn.ToRound()
    }

    @IBAction func LoginButton(_ sender: Any) {
        let (error_title, error_text) = validateTextFields()

        if error_title != nil && error_text != nil {
            showError(error_title!, error_text!)
        }

        email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = PasswordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchData.predicate = NSPredicate(format: "email = %@", email)
        fetchData.predicate = NSPredicate(format: "password = %@", password)

        do {
            let results = try manageContext.fetch(fetchData)
            print("resulets data",results)

            if results.isEmpty {
                showError("Invalid Credentials", "If you don't have a account try to SignUp...")
            }

            for data in results as! [NSManagedObject] {
                age = data.value(forKey: "age") as! String
                phone = data.value(forKey: "phone") as! String
                email = data.value(forKey: "email") as! String
                password = data.value(forKey: "password") as! String
            }

            toStatusViewController()
            toClearAll()
        } catch {
            showError("User Not Found", "Try to Sign Up")
        }
    }

    func validateTextFields() -> (String?, String?) {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || PasswordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return ("Empty Fields", "Please Enter in all Fields")
        }
        return (nil, nil)
    }

    @IBAction func signUpBtnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    func showError(_ title: String, _ message: String) {
        present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
    }

    func toStatusViewController() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StatusViewController") as! StatusViewController
        vc.modalPresentationStyle = .fullScreen
        self.defaults.set(true, forKey: "isUserLoggedIn")
        present(vc, animated: true, completion: nil)
        
    }

    func toClearAll() {
        emailTextField.text = ""
        PasswordTextFiled.text = ""
    }
}
