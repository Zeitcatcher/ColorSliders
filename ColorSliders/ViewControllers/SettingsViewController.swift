//
//  ViewController.swift
//  ColorSliders
//
//  Created by Arseniy Oksenoyt on 7/30/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var viewColor: UIColor!
    var delegate: ColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColorSliders(with: viewColor)
        setupTextFieldsFromSliders(with: redSlider, greenColor: greenSlider, blueColor: blueSlider)
        colorView.layer.cornerRadius = 15
        colorSetup()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func rgbSliderChange(_ sender: UISlider) {
        colorSetup()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: sender);
            redTextField.text = string(from: sender)
        case greenSlider:
            greenLabel.text = string(from: sender);
            greenTextField.text = string(from: sender)
        default:
            blueLabel.text = string(from: sender);
            blueTextField.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPressed() {
        guard let color = colorView.backgroundColor else { return }
        
        delegate.backgroundColorSetup(with: color)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for lables: UILabel...) {
        lables.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func colorSetup() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setupColorSliders(with color: UIColor) {
        var redColor: CGFloat = 0
        var greenColor: CGFloat = 0
        var blueColor: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&redColor, green: &greenColor, blue: &blueColor, alpha: &alpha)
        
        redSlider.setValue(Float(redColor), animated: false)
        greenSlider.setValue(Float(greenColor), animated: false)
        blueSlider.setValue(Float(blueColor), animated: false)
    }
    
    private func setupTextFieldsFromSliders(with redColor: UISlider, greenColor: UISlider, blueColor: UISlider) {
        redTextField.text = string(from: redColor)
        greenTextField.text = string(from: greenColor)
        blueTextField.text = string(from: blueColor)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}
// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            }
            
            colorSetup()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

