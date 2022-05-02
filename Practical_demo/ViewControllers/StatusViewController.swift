
import UIKit

class StatusViewController: UIViewController {
    let defaults = UserDefaults.standard
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startbtn: UIButton!
    @IBOutlet var stopbtn: UIButton!
    @IBOutlet var resetbtn: UIButton!

    var bgtask = 0
    var timer = Timer()
    var fractions: Int = 0
    var seconds: Int = 0
    var minutes: Int = 0
    var timerStarted: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        present(CustomAlert.alertMessage("SuccessFully Logged In ", "Thank You"), animated: true, completion: nil)
        timerLabel.text = "00:00.00"

        startbtn.isEnabled = true
        stopbtn.isEnabled = false
        resetbtn.isEnabled = false
    }

    @IBAction func startTimer(_ sender: Any) {
        if timerStarted == false {
            if bgtask == 0 {
                bgtask = 1
                registerBackgroundTask()
            }
            timerStarted = true

            inBackground()

            startbtn.isEnabled = false
            stopbtn.isEnabled = true
            resetbtn.isEnabled = true
        }
    }

    @IBAction func stopTimer(_ sender: Any) {
        if timerStarted == true {
            timerStarted = false
            timer.invalidate()
            stopbtn.isEnabled = false
            startbtn.isEnabled = true
            resetbtn.isEnabled = true

            if bgtask == 1 {
                endBackgroundTask()
                bgtask = 0
            }
        }
    }

    @IBAction func resetTimer(_ sender: Any) {
        timer.invalidate()

        fractions = 0
        seconds = 0
        minutes = 0

        timerStarted = false

        startbtn.isEnabled = true
        stopbtn.isEnabled = false
        resetbtn.isEnabled = false

        timerLabel.text = "00:00.00"

        if bgtask == 1 {
            endBackgroundTask()
            bgtask = 0
        }
    }

    @IBAction func dismissBtnClick(_ sender: UIButton) {
        defaults.set(false, forKey: "isUserLoggedIn")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    func inBackground() {
        // call endBackgroundTask() on completion..

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }

    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }

    @objc func updateTimer() {
        fractions += 1

        if fractions == 100 {
            fractions = 0
            seconds += 1
        }

        if seconds == 60 {
            seconds = 0
            minutes += 1
        }

        let fracStr: String = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secStr: String = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minStr: String = minutes > 9 ? "\(minutes)" : "0\(minutes)"

        timerLabel.text = "\(minStr):\(secStr).\(fracStr)"
    }
}
