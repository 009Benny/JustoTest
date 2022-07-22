//
//  HomeViewController.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import UIKit

class HomeViewController: UITableViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    var spinner = UIActivityIndicatorView(style: .large)
    var users:[User] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI(){
        title = "Lista de personas"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter?.loadData()
        tableView.rowHeight = 60
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    }
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else{
            let cell = UITableViewCell()
            cell.textLabel?.text = users[indexPath.row].name
            return cell
        }
        cell.user = users[indexPath.row]
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hapticFeedBack = UINotificationFeedbackGenerator()
        hapticFeedBack.notificationOccurred(.success)
        presenter?.showDetail(of: users[indexPath.row])
    }
    
    // MARK: Spinner
    func showSpinner() {
        spinner.startAnimating()
        spinner.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        view.addSubview(spinner)
        
    }
    
    func removeSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    // MARK: Message
    func showAlertMessage(_ message:String, title:String = ""){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Continuar", style: .default) { finish in
            alert.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
                         
}
