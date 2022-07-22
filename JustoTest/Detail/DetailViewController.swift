//
//  DetailViewController.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import UIKit
import Alamofire


class DetailViewController: UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var personalInfo: UILabel!
    @IBOutlet weak var resume: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    let user:User
    
    init(user:User) {
        self.user = user
        super.init(nibName: String(describing: DetailViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI(){
        title = "Perfil de \(user.name)"
        stackView.setCustomSpacing(20, after: resume)
        
        imgProfile.layer.cornerRadius = imgProfile.bounds.width / 2
        imgProfile.clipsToBounds = true
        
        load(image: user.profilePicture.large)
        fullName.text = user.fullName
        personalInfo.text = "\(user.nationality) - \(user.age) años"
        resume.text = "Hola mi nombre es \(user.name) y estoy ofreciendo mis servicios a muy buen precio, pudes marcarme para mas información o enviarme un correo electronico"
    }

    func load(image src:String){
        AF.request(src).responseData { response in
            guard let data = response.data else{
                self.imgProfile.image = UIImage(systemName: "person.fill.xmark")
                return
            }
            self.imgProfile.image = UIImage(data: data)
        }
    }
    
    func callPhoneAction(){
        if let url = URL(string: "tel://\(user.phone)"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }
    }
    
    func sendEmail(){
        // PENDING EMAIL
    }
    
    @IBAction func btnCallAction(_ sender: Any) {
        callPhoneAction()
    }
    
    @IBAction func btnSendEmail(_ sender: Any) {
        sendEmail()
    }
}
