//
//  GRAlertViewController.swift
//  groov
//
//  Created by PilGwonKim on 2018. 3. 18..
//  Copyright © 2018년 PilGwonKim. All rights reserved.
//

import UIKit

protocol GRAlertViewControllerDelegate: class {
    func alertViewAddButtonTouched(title: String)
}

class GRAlertViewController: BaseViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var alertView: UIView!
    @IBOutlet var alertViewTop: NSLayoutConstraint!
    
    weak var delegate: GRAlertViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    func initViews() {
        // patternize views
        descriptionLabel.textColor = UIColor.init(patternImage: #imageLiteral(resourceName: "loading_gradation_middle"))
        addButton.setTitleColor(UIColor.init(patternImage: #imageLiteral(resourceName: "loading_gradation_short")), for: .normal)
        
        addButton.setTitle(L10n.add, for: .normal)
        cancelButton.setTitle(L10n.cancel, for: .normal)
        
        // notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

// MARK: Notification Center
extension GRAlertViewController {
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            alertViewTop.constant = (keyboardSize.origin.y - alertView.height) / 2
            view.layoutIfNeeded()
        }
    }
}

// MARK: IBActions
extension GRAlertViewController {
    @IBAction func cancelButtonClicked() {
        dismissWithFade()
    }
    
    @IBAction func addButtonClicked() {
        if let text = titleTextField.text {
            if text != "" {
                titleTextField.resignFirstResponder()
                delegate?.alertViewAddButtonTouched(title: text)
                dismissWithFade()
            }
        }
    }
}
