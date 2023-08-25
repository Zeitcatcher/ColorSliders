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
    
//    private func addingToolbarToKeyboard(to textfield: UITextField) {
//        let toolbar = UIToolbar()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
//        toolbar.setItems([doneButton], animated: false)
//        textfield.inputAccessoryView = toolbar
//
//    }
//
//    @objc func doneButtonTapped(for textField: UITextField) {
//        textField.resignFirstResponder()
//    }
}
