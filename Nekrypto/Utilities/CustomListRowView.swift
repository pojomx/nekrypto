//
//  CustomRowView.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import SwiftUI

struct CustomListRowView: View {

    @State var rowContent: String
    @State var rowContent2: String?
    @State var rowLabel: String
    @State var rowIcon: String
    @State var rowTintColor: Color

    var body: some View {
        LabeledContent {
            VStack (alignment: .trailing) {
                Text(rowContent)
                    .tint(.primary)
                    .fontWeight(.medium)
                if let content2 = rowContent2 {
                    Text(content2)
                        .tint(.secondary)
                        .font(.caption)
                        .fontWeight(.light)
                }
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
        CustomListRowView(rowContent: "pojomx", rowContent2: "Second Row", rowLabel: "test", rowIcon: "cloud", rowTintColor: .green)
    }
}
