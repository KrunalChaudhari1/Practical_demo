
import Foundation
import UIKit

func isPasswordHaveCharacters(password: String) -> Bool {
    for char in password {
        if char >= "a" && char <= "z" || char >= "A" && char <= "Z" {
            return true
        }
    }
    return false
}

func isLengthOfPasswordISgreaterThenEight(password: String) -> Bool {
    return password.count >= 8 ? true : false
}

func isPasswordHaveSpecialSymbol(password: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
        if let _ = regex.firstMatch(in: password, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, password.count)) {
            return true
        }

    } catch {
        debugPrint(error.localizedDescription)
        return false
    }

    return false
}

func isPasswordHaveDigits(password: String) -> Bool {
    for char in password {
        if char >= "0" && char <= "9" {
            return true
        }
    }
    return false
}

// MARK: - isPasswordStrong

func isPasswordStrong(password: String) -> Bool {
    if isPasswordHaveDigits(password: password) && isPasswordHaveCharacters(password: password) && isLengthOfPasswordISgreaterThenEight(password: password) && isPasswordHaveSpecialSymbol(password: password) {
        return true
    } else {
        return false
    }
}
