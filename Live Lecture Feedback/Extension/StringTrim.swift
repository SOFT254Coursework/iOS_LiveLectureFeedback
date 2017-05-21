//
//  StringTrim.swift
//  Live Lecture Feedback
//
//  Created by Wing Chau on 21/5/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
