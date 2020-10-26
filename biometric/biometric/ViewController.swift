//
//  ViewController.swift
//  biometric
//
//  Created by Hamza Mustafa on 23/10/2020.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    let context = LAContext()
    @IBOutlet weak var identityBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func fingerPrintBtPressed(_ sender: UIButton) {
        myIdentity()
    }
    
    func myIdentity(){
        var error:NSError?
        guard self.context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error)
        }
        //Check Availibility
        if self.context.biometryType == .faceID {
            print("face id")
            self.identityBt.setImage(UIImage(named: "face-recognition"), for: .normal)
        }
        else if self.context.biometryType == .touchID{
            print("touch id")
            self.identityBt.setImage(UIImage(named: "fingerprint"), for: .normal)
        }
        else{
            print("none")
        }
        
        
        let reason = "Identification"
        self.context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
            if success{
                print("success")
            }
            else{
                print("error")
                if let err = error {
                    var message = ""
                    let evalError = LAError(_nsError: err as NSError)
                    switch evalError.code {
                        case LAError.authenticationFailed:
                            message = "There was a problem verifying your identity."
                        case LAError.userCancel:
                            print("You pressed cancel.")
                        case LAError.systemCancel:
                            message = "Authentication is cancelled by the system."
                        case LAError.passcodeNotSet:
                            message = "Passcode is not set in this device."
                        case LAError.userFallback:
                            print("You pressed password.")
                        case LAError.biometryNotAvailable:
                            message = "Face ID/Touch ID is not available."
                        case LAError.biometryNotEnrolled:
                            message = "Face ID/Touch ID is not set up."
                        case LAError.biometryLockout:
                            message = "Face ID/Touch ID is locked."
                        default:
                            message = "There was a problem verifying your identity. Try again!"
                    }
                    print("LaError message = \(message)")
                }
            }
        }
    }// myIdentity
}
