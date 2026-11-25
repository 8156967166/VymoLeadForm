//
//  DSFieldView.swift
//  VymoDesignSystem
//
//  Created by Aneesha P A on 24/11/26.
//


import SwiftUI

public struct DSFieldView<Content: View>: View {

    private let label: String
    private let hint: String?
    private let error: String?
    private let content: Content

    public init(
        label: String,
        hint: String? = nil,
        error: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.hint = hint
        self.error = error
        self.content = content()
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: DSSpacing.small) {

            Text(label)
                .font(DSTypography.body)
                .foregroundStyle(DSColors.textPrimary)

            content

            if let hint = hint {
                Text(hint)
                    .font(DSTypography.caption)
                    .foregroundStyle(DSColors.textSecondary)
            }

            if let error = error {
                Text(error)
                    .font(DSTypography.caption)
                    .foregroundStyle(DSColors.error)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
