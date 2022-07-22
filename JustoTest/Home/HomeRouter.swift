//
//  HomeRouter.swift
//  JustoTest
//
//  Homed by Benny Reyes on 22/07/22.
//

import UIKit

public class HomeRouter: HomeWireframeProtocol {
    weak var viewController: HomeViewController?
    
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
    
    func showDetail(of user: User) {
        viewController?.navigationController?.pushViewController(DetailViewController(user: user), animated: true)
    }
    
}
