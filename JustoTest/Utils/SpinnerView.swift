//
//  SpinnerView.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import UIKit

class SpinnerViewController:UIViewController{
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.tintColor = .white
        spinner.backgroundColor = .white
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func add(to parent: UIViewController) {
        parent.addChild(self)
        self.view.frame = parent.view.frame
        parent.view.addSubview(self.view)
        self.didMove(toParent: parent)
    }

    public func remove(){
        // wait two seconds to simulate some work happening
        // then remove the spinner view controller
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
