//
//  ViewControllerExtension.swift
//  JustoTest
//
//  Created by Benny Reyes on 24/07/22.
//

import UIKit

extension UIViewController{
     
    // Add gradient to main view of controller
    func configGradientBackground(to view:UIView){
        view.layoutIfNeeded()
        guard let accent = UIColor(named: "JustoColor") else { return }
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradient.colors = [accent.cgColor, UIColor.white.cgColor]
        view.layer.addSublayer(gradient)
    }
    
}
