//
//  HomePresenter.swift
//  JustoTest
//
//  Homed by Benny Reyes on 22/07/22.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeWireframeProtocol
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func loadData() {
        view?.showSpinner()
        interactor?.getUsers(cant: Int.random(in: 10..<50), completition: { [weak self] response in
            self?.view?.removeSpinner()
            switch response{
            case .success(let data):
                guard let users = data as? [User] else { return }
                self?.view?.users = users
                break
            case .failure(let message):
                self?.view?.showAlertMessage(message.rawValue, title: "Error")
            }
        })
    }
    
    func showDetail(of user:User){
        router.showDetail(of: user)
    }
    
}

