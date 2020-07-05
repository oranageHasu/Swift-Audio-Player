//
//  CheckboxToggleStyle.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-07-01.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
                .foregroundColor(Color.blue)
        }
    }
}
