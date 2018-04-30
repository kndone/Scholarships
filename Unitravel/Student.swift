//
//  Student.swift
//  Unitravel
//
//  Created by Misael Garay on 09/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse

public class Student : PFUser {
    
    public var idStudent : String? = nil {
        didSet{
            self.setValue(idStudent, forKey: "idStudent")
        }
    }
    
    public var visa : Bool? = nil {
        didSet{
            self.setValue(visa, forKey: "visa")
        }
    }
    
    public var lastName : String? = nil {
        didSet{
            self.setValue(lastName, forKey: "lastName")
        }
    }
    
    public var institutionName : String? = nil {
        didSet{
            self.setValue(institutionName, forKey: "institutionName")
        }
    }
    
    public var telephone : String? = nil {
        didSet{
            self.setValue(telephone, forKey: "telephone")
        }
    }
    
    public var level : String? = nil {
        didSet{
            self.setValue(level, forKey: "level")
        }
    }
    
    public var degree : String? = nil {
        didSet{
            self.setValue(degree, forKey: "degree")
        }
    }
    
    public var rol : String? = nil{
        didSet{
            self.setValue(rol, forKey: "rol")
        }
    }
    
    public var passport : Bool? = nil {
        didSet{
            self.setValue(passport, forKey: "passport")
        }
    }
    
    public var country : String? = nil {
        didSet{
            self.setValue(country, forKey: "country")
        }
    }
    
    public var firstName : String? = nil {
        didSet{
            self.setValue(firstName, forKey: "firstName")
        }
    }
    
    public var average : Float? = nil {
        didSet{
            self.setValue(average, forKey: "average")
        }
    }
    
    public var career : String? = nil{
        didSet{
            self.setValue(career, forKey: "career")
        }
    }
    
    public var image : UIImage? = nil {
        didSet{
            guard let noImage = image else {
               let file = PFFile(name: "profileDefault.png", data: UIImagePNGRepresentation(#imageLiteral(resourceName: "placeUser"))!)
                self.setValue(file, forKey: "image")
                return
            }
            let file = PFFile(name: "profile.png", data: UIImagePNGRepresentation(noImage)!)
            self.setValue(file, forKey: "image")
        }
    }
    
    public override init() {
        super.init()
    }
    
}

public class StudentTest {
    public static func LoginWithDefaultSession(block : @escaping () -> ()){
        PFUser.logInWithUsername(inBackground: "r@r.com", password: "r", block: {
            (success, error) in
            if error != nil {
                print("Error in test Login")
                return
            }
            print("loged in with default session")
            block()
        })
    }
}


