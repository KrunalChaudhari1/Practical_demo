
import CoreData
import Foundation
import UIKit

let app = UIApplication.shared.delegate as? AppDelegate
let context = app?.persistentContainer.viewContext

// MARK: - saveDataToUserEntity

func saveDataToUserEntity(username: String, email: String, password: String, phone: String) -> Bool {
    // core data connection step
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context!)
    let user = NSManagedObject(entity: entity!, insertInto: context)

    user.setValue(username, forKey: "age")
    user.setValue(email, forKey: "email")
    user.setValue(password, forKey: "password")
    user.setValue(phone, forKey: "phone")

    do {
        try context!.save()
        return true
    } catch let err {
        print(err)
        return false
    }
}

// MARK: - loginToUserEntity

func loginToUserEntity(user: String, pass: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.returnsObjectsAsFaults = false

    do {
        let result = try context!.fetch(request)
        for data in result as! [NSManagedObject] {
            if data.value(forKey: "username") as! String == user && data.value(forKey: "password") as! String == pass {
                return true
            }
        }
        return false

    } catch let err as NSError {
        print(err)
    }
    return true
}

// MARK: - updateUserEntityDataByUserName

func updateUserEntityDataByUserName(username: String, newPass: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.returnsObjectsAsFaults = false
    var user = ""
    var email = ""
    var phone = ""
    do {
        let result = try context!.fetch(request)
        for data in result as! [NSManagedObject] {
            if data.value(forKey: "username") as! String == username {
                user = data.value(forKey: "username") as! String
                email = data.value(forKey: "email") as! String
                phone = data.value(forKey: "phone") as! String

                data.setValue(user, forKey: "username")
                data.setValue(email, forKey: "email")
                data.setValue(newPass, forKey: "password")
                data.setValue(phone, forKey: "phone")
                do {
                    try context!.save()
                } catch {
                    print(error)
                    return false
                }
            }
        }

    } catch let err as NSError {
        print(err)
        return false
    }
    return true
}

// MARK: - deleteUserEntityDataByUsername

func deleteUserEntityDataByUsername(entity: String, username: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    request.returnsObjectsAsFaults = false
    do {
        let result = try context!.fetch(request)
        for data in result as! [NSManagedObject] {
            if data.value(forKey: "username") as! String == username {
                context?.delete(data)
                do {
                    try context!.save()
                    return true
                } catch {
                    print(error)
                    return false
                }
            }
        }
    } catch {
        print(error)
        return false
    }
    return false
}
