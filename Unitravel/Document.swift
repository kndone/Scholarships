//
//  Document.swift
//  Unitravel
//
//  Created by Misael Garay on 16/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit

public class Document {
    
    
}

public enum DocumentType : String {
    case PASSPORT = "Passport"
    case PROPOSAL_LETTER = "Proposal Letter"
    case RECOMENDATION_LETTER = "Recommendation letter"
    case STATEMENT = "Statement of purpose"
    case RESUME_SPA = "Resumee(Spanish)"
    case RESUME_EN = "Resumee(English)"
    case BIRTH_CERTIFICATE = "Birth Certificate"
}

public var Documents : [String] = [
    DocumentType.PASSPORT.rawValue,
    DocumentType.PROPOSAL_LETTER.rawValue,
    DocumentType.RECOMENDATION_LETTER.rawValue,
    DocumentType.STATEMENT.rawValue,
    DocumentType.RESUME_SPA.rawValue,
    DocumentType.RESUME_EN.rawValue,
    DocumentType.BIRTH_CERTIFICATE.rawValue
]

public class DocumentService {
    
}
