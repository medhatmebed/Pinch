//
//  PageModel.swift
//  Pinch
//
//  Created by Medhat Mebed on 12/21/23.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
