//
//  DSCheckbox.swift
//  VymoDesignSystem
//
//  Created by Aneesha P A on 24/11/26.
//


import SwiftUI

public struct DSCheckbox: View {

    @Binding private var isChecked: Bool

    private let title: String

    public init(
        isChecked: Binding<Bool>,
        title: String
    ) {
        self._isChecked = isChecked
        self.title = title
    }

    public var body: some View {

        Button {

            isChecked.toggle()

        } label: {

            HStack(spacing: DSSpacing.small) {

                Image(
                    systemName: isChecked
                    ? "checkmark.square.fill"
                    : "square"
                )
                .font(.title3)
                .foregroundStyle(
                    isChecked
                    ? DSColors.primary
                    : DSColors.textSecondary
                )

                Text(title)
                    .font(DSTypography.body)
                    .foregroundStyle(DSColors.textPrimary)

            }
        }
        .buttonStyle(.plain)
    }
}
