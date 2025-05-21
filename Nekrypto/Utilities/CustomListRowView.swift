//
//  CustomRowView.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import SwiftUI

struct CustomListRowView: View {

    @State var rowContent: String
    @State var rowLabel: String
    @State var rowIcon: String
    @State var rowTintColor: Color

    var body: some View {
        LabeledContent {
            VStack (alignment: .trailing) {
                Text(rowContent)
                    .tint(.primary)
                    .fontWeight(.medium)
            }
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 30)
                        .foregroundColor(rowTintColor)
                    Image(systemName: rowIcon)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                Text(rowLabel)
            }
        }
    }
}

#Preview {
    List {
        CustomListRowView(rowContent: "pojomx", rowLabel: "test", rowIcon: "cloud", rowTintColor: .pink)
    }
}
