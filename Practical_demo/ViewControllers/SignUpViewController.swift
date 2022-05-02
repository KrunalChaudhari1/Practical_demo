

import CoreData
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var dismissBtn: UIButton!

    var age = ""
    var email = ""
    var phone = ""
    var password = ""

    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var SignUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpButton.ToRound()
    }

    @IBAction func SignUpButton(_ sender: Any) {
        let (error_title, error_text) = validateTextFields()

        if error_title != nil && error_text != nil {
            showError(error_title!, error_text!)
        }

        age = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: manageContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: manageContext)

        user.setValue(age, forKey: "age")
        user.setValue(email, forKey: "email")
        user.setValue(phone, forKey: "phone")
        user.setValue(password, forKey: "password")

        do {
            try manageContext.save()
            print("Value Saved")

            showError("Sucessfully Signed Up", "Go to Login and try ..")
            toClearAll()
        } catch {
            showError("Try Again", "Try with another email and password")
        }
    }

    @IBAction func dismissBtnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func validateTextFields() -> (String?, String?) {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""

        {
            return ("Empty Fields", "Please Enter in all Fields")
        }
        return (nil, nil)
    }

    func showError(_ title: String, _ message: String) {
        present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
    }

    func toClearAll() {
        ageTextField.text = ""
        phoneTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
