//
//  DetailViewController.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import UIKit
import Alamofire
import MessageUI

// This class is a view to specific user with buttons that can call to the user or send a email
final class DetailViewController: UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var personalInfo: UILabel!
    @IBOutlet weak var resume: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var gradientView: UIView?
    let user:User
    
    private lazy var topView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = navigationController?.navigationBar.backgroundColor
        return view
    }()
    
    init(user:User) {
        self.user = user
        super.init(nibName: String(describing: DetailViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let gradient = gradientView{
            configGradientBackground(to: gradient)
        }
    }
    
    // MARK: CONFIG UI
    func configUI(){
        title = "Perfil de \(user.name)"
        
        view.addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        
        stackView.setCustomSpacing(20, after: resume)
        imgProfile.layer.cornerRadius = imgProfile.bounds.width / 2
        imgProfile.clipsToBounds = true
        
        // SET CUSTOM DATA
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
    
    // This method display a system alert with the option to cancel or call the number
    func callPhoneAction(){
        if let phoneCallURL = URL(string: "tel://\(user.phone.getOnlyNumbers())") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    // This method comprobe if device can send email and if it can, then will present a mailView
    func sendEmail(){
        if user.email.isEmpty || !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["\(user.email)"])
        print("Send email to \(user.email)")
        navigationController?.present(mail, animated: true)
    }
    
    @IBAction func btnCallAction(_ sender: Any) {
        callPhoneAction()
    }
    
    @IBAction func btnSendEmail(_ sender: Any) {
        sendEmail()
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension DetailViewController:MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(result)
    }
}
