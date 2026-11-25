//
//  DSButton.swift
//  VymoDesignSystem
//
//  Created by Aneesha P A on 24/11/26.
//


import SwiftUI

public struct DSButton: View {

    private let title: String
    private let action: () -> Void

    public init(
        title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }

    public var body: some View {

        Button(action: action) {

            Text(title)
                .font(DSTypography.button)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(DSSpacing.medium)
                .background(DSColors.primary)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
        }
        .buttonStyle(.plain)
    }
}

