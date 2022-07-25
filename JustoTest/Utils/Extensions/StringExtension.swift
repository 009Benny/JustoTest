//
//  StringExtension.swift
//  JustoTest
//
//  Created by Benny Reyes on 25/07/22.
//

import Foundation

extension String{
    func getOnlyNumbers()->String{
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
    }
}
