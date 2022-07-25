//
//  HomeProtocols.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import Foundation

//MARK: Wireframe -
protocol HomeWireframeProtocol: AnyObject {
    func showDetail(of user:User)
}

//MARK: Presenter -
protocol HomePresenterProtocol: AnyObject {
    func loadData(refresh:Bool)
    func showDetail(of user:User)
}

//MARK: Interactor -
protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }
    
    func getUsers(cant:Int, completition: @escaping ServiceCompletition)
}

//MARK: View -
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }
    var users:[User] { get set }
    
    func endRefresh()
    func showSpinner()
    func removeSpinner()
    func showAlertMessage(_ message:String, title:String)
}
