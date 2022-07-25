//
//  HomeRouter.swift
//  JustoTest
//
//  Homed by Benny Reyes on 22/07/22.
//

import UIKit

public class HomeRouter: HomeWireframeProtocol {
    weak var viewController: HomeViewController?
    
    // Build HomeController with VIPER struct
    static func buildModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    // Push a detail view to specific user
    func showDetail(of user: User) {
        viewController?.navigationController?.pushViewController(DetailViewController(user: user), animated: true)
    }
    
}
