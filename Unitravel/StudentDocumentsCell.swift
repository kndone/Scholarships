//
//  StudentDocumentsCell.swift
//  Unitravel
//
//  Created by Misael Garay on 15/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit

class StudentDocumentCell : UICollectionViewCell {
    
    private var fileImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "doc")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public var fileName : UILabel = {
        let label = UILabel()
        label.text = "File name"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var statusId : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var status : Bool = false {
        didSet{
            statusId.backgroundColor = status ? UIColor.green : UIColor.red
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.groupTableViewBackground.cgColor
        clipsToBounds = true
        layer.cornerRadius = 10
        addSubview(fileImage)
        addSubview(fileName)
        addSubview(statusId)
        SetupFileImage()
        SetupFileName()
        SetupStatusId()
    }
    
    private func SetupStatusId(){
        statusId.heightAnchor.constraint(equalToConstant: 10).isActive = true
        statusId.widthAnchor.constraint(equalToConstant: 10).isActive = true
        statusId.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        statusId.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    private func SetupFileImage(){
        fileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        fileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        fileImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        fileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
    
    private func SetupFileName(){
        fileName.topAnchor.constraint(equalTo: fileImage.bottomAnchor).isActive = true
        fileName.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        fileName.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        fileName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
