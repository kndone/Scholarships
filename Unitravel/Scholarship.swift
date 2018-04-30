//
//  Scholarship.swift
//  Unitravel
//
//  Created by Misael Garay on 14/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse

public class Scholarship {
    public var name : String?
    public weak var idUser : PFUser?
    public var country : String?
    public var docRequired : [String]?
    public var description : String?
    public var initDate : Date?
    public var institution : String?
    public var pfScholarship : PFObject?
    public var endDate : Date?
    
    init(pfObject : PFObject?) {
        guard let pfScholarship = pfObject else {
            print("no pfObjetc passed")
            return
        }
        self.pfScholarship = pfScholarship
        name = pfScholarship["name"] as? String
        country = pfScholarship["country"] as? String
        idUser = pfScholarship["idUser"] as? PFUser
        endDate = pfScholarship["endDate"] as? Date
        description = pfScholarship["description"] as? String
    }
}

public class ScholarshipService {
    
    public static func GetScholarships( block : @escaping ([Scholarship]) -> ()){
        var scholarships = [Scholarship]()
        let scholarshipsQuery = PFQuery(className: "Scholarship")
        scholarshipsQuery.findObjectsInBackground(block: {
            (pfScholarships, error) in
            if error != nil {
                print("Can't get scholarships")
                return
            }
            for pfScholarship in pfScholarships! {
                let scholarship = Scholarship(pfObject: pfScholarship)
                UserInstService.GetInstitucionBy(id: scholarship.idUser?.objectId, block: { (userInst, error) in
                    if error != nil {
                        return
                    }
                    scholarship.institution = userInst?.institutionName
                    scholarships.append(scholarship)
                    block(scholarships)
                })
                
            }
            
            
        })
    }
}
