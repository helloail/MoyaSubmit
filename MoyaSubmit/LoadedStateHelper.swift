//
//  LoadedStateHelper.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 18/03/21.
//

import Foundation
enum LoadedStateHelper {
    case idle
    case loading
    case error(Error)
    case loaded
    case empty
}
