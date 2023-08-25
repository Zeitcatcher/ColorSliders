//
//  ColorViewController.swift
//  ColorSliders
//
//  Created by Arseniy Oksenoyt on 8/24/23.
//

import UIKit

protocol ColorViewControllerDelegate {
    func backgroundColorSetup(with color: UIColor)
}

class ColorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = rgbColorSetup()
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettingsViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
    private func rgbColorSetup(red: Float = 1, green: Float = 1, blue: Float = 1, alpha: Float = 1) -> UIColor {
        let finalColor = UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha)
        )
        return finalColor
    }
}

extension ColorViewController: ColorViewControllerDelegate {
    func backgroundColorSetup(with color: UIColor) {
        view.backgroundColor = color
    }
}
