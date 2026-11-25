//
//  DSSelectField.swift
//  VymoDesignSystem
//
//  Created by Aneesha P A on 24/11/26.


import SwiftUI

public struct DSSelectField: View {

    @Binding private var selection: String

    private let options: [String]
    private let placeholder: String

    public init(
        selection: Binding<String>,
        options: [String],
        placeholder: String = "Select an option"
    ) {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
    }

    public var body: some View {

        Menu {

            ForEach(options, id: \.self) { option in

                Button(option) {
                    selection = option
                }
            }

        } label: {

            HStack {

                Text(
                    selection.isEmpty
                    ? placeholder
                    : selection
                )
                .foregroundStyle(
                    selection.isEmpty
                    ? DSColors.textSecondary
                    : DSColors.textPrimary
                )

                Spacer()

                Image(systemName: "chevron.down")
                    .foregroundStyle(DSColors.textSecondary)
            }
            .font(DSTypography.body)
            .padding(DSSpacing.medium)
            .background(DSColors.inputBackground)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(DSColors.border, lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
