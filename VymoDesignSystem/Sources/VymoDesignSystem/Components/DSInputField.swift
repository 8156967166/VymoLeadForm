//
//  DSInputField.swift
//  VymoDesignSystem
//
//  Created by Aneesha P A on 24/11/26.


import SwiftUI
import UIKit

public struct DSInputField: View {

    @Binding private var text: String

    private let placeholder: String
    private let keyboardType: UIKeyboardType
    private let onEditingChanged: (Bool) -> Void

    public init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {

        TextField(
            placeholder,
            text: $text,
            onEditingChanged: onEditingChanged
        )
        .keyboardType(keyboardType)
        .font(DSTypography.body)
        .padding(DSSpacing.medium)
        .background(DSColors.inputBackground)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(DSColors.border, lineWidth: 1)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}
