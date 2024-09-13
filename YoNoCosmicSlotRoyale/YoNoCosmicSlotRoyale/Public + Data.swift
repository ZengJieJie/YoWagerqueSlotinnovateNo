//
//  Public + Data.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import Foundation

var history:[String] = []{
    didSet{
        UserDefaults.standard.setValue(history, forKey: "his")
    }
}
