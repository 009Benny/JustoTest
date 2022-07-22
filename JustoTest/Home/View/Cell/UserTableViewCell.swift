//
//  UserTableViewCell.swift
//  JustoTest
//
//  Created by Benny Reyes on 22/07/22.
//

import UIKit
import Alamofire

class UserCell: UITableViewCell {
    static let identifier = String(describing: self)
    var user:User? { didSet { updateData() } }
    
    private let fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let basicInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.fill")
        img.sizeToFit()
        img.contentMode = .scaleToFill
        img.tintColor = .black
        return img
    }()
    
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [fullName, basicInformation])
        stack.spacing = 8
        stack.axis = .vertical
        
        addSubview(image)
        addSubview(stack)
        
        let width = bounds.height * 0.8
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: width).isActive = true
        image.widthAnchor.constraint(equalToConstant: width).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        image.layer.cornerRadius = width / 2
        image.clipsToBounds = true
        
        
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20).isActive = true
    }
    
    // MARK: UpdateData
    func updateData(){
        guard let usr = user else { return }
        fullName.text = usr.fullName
        basicInformation.text =  "\(usr.nationality) - \(usr.age) años"
        load(image: usr.profilePicture.thumbnail)
    }
    
    func load(image src:String){
        AF.request(src).responseData { response in
            guard let data = response.data else{
                self.image.image = UIImage(systemName: "person.fill.xmark")
                return
            }
            self.image.image = UIImage(data: data)
        }
    }
}
