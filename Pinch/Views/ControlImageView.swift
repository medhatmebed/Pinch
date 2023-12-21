//
//  ControlImageView.swift
//  Pinch
//
//  Created by Medhat Mebed on 12/21/23.
//

import SwiftUI

struct ControlImageView: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
        .previewLayout(.sizeThatFits)
        .padding()
}
