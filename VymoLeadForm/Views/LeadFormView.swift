//
//  LeadFormView.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//


import SwiftUI
import VymoDesignSystem

struct LeadFormView: View {

    @StateObject private var viewModel = LeadFormViewModel()

    @Environment(\.horizontalSizeClass) private var sizeClass

    @State private var availableWidth: CGFloat = 0

    @FocusState private var focusedField: String?

    private var isWideLayout: Bool {
        availableWidth >= DSLayout.twoColumnBreakpoint
    }

    private let columns = [
        GridItem(.flexible(), spacing: DSSpacing.large),
        GridItem(.flexible(), spacing: DSSpacing.large)
    ]

    var body: some View {

        GeometryReader { geometry in

            let wide = geometry.size.width >= DSLayout.twoColumnBreakpoint

            ScrollViewReader { proxy in

                ScrollView {

                    VStack(alignment: .leading, spacing: DSSpacing.large) {

                        VStack(alignment: .leading, spacing: DSSpacing.small) {

                            Text("Lead Registration")
                                .font(DSTypography.heading)
                                .foregroundStyle(DSColors.textPrimary)

                            Text("Please enter your details below.")
                                .font(DSTypography.body)
                                .foregroundStyle(DSColors.textSecondary)
                        }

                        LazyVGrid(
                            columns: wide ? columns : [GridItem(.flexible())],
                            alignment: .leading,
                            spacing: DSSpacing.large
                        ) {

                            ForEach(viewModel.config) { field in

                                if viewModel.isFieldVisible(field) {

                                    fieldView(for: field)
                                        .id(field.name)
                                        .gridCellColumns(
                                            wide && (
                                                field.type == .textarea ||
                                                field.type == .checkbox
                                            ) ? 2 : 1
                                        )
                                }
                            }
                        }

                        if let submitted = viewModel.submittedValues {
                            submittedValuesView(submitted)
                        }
                    }
                    .padding(DSSpacing.large)
                    .frame(maxWidth: 900)
                    .frame(maxWidth: .infinity)
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: focusedField) { _, newValue in

                    if let field = newValue {

                        withAnimation {
                            proxy.scrollTo(field, anchor: .center)
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {

                    DSButton(title: "Submit") {

                        focusedField = nil
                        viewModel.submitForm()
                    }
                    .padding(.horizontal, DSSpacing.large)
                    .padding(.vertical, DSSpacing.small)
                    .background(DSColors.background)
                }
            }
            .onAppear {
                availableWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { _, newWidth in
                availableWidth = newWidth
            }
        }
        .background(DSColors.background)
    }

    // MARK: - Dynamic Field Rendering

    @ViewBuilder
    private func fieldView(for field: FormField) -> some View {

        let binding = Binding<String>(
            get: {
                viewModel.values[field.name] ?? ""
            },
            set: { newValue in
                viewModel.updateValue(
                    for: field.name,
                    value: newValue
                )
            }
        )

        switch field.type {

        case .text, .email:

            DSFieldView(
                label: field.label,
                hint: field.hint,
                error: viewModel.errors[field.name]
            ) {

                DSInputField(
                    text: binding,
                    placeholder: field.placeholder,
                    keyboardType: field.type == .email
                        ? .emailAddress
                        : field.name == "phone"
                            ? .numberPad
                            : .default,
                    onEditingChanged: { isEditing in

                        if isEditing {
                            focusedField = field.name
                        } else {
                            viewModel.validateOnBlur(field.name)
                            focusedField = nil
                        }
                    }
                )
            }

        case .select:

            DSFieldView(
                label: field.label,
                hint: field.hint,
                error: viewModel.errors[field.name]
            ) {

                DSSelectField(
                    selection: binding,
                    options: field.options,
                    placeholder: field.placeholder
                )
                .onChange(of: binding.wrappedValue) { _, _ in
                    viewModel.validateOnBlur(field.name)
                }
            }

        case .textarea:

            DSFieldView(
                label: field.label,
                hint: "\(binding.wrappedValue.count)/200 characters",
                error: viewModel.errors[field.name]
            ) {

                TextEditor(text: binding)
                    .font(DSTypography.body)
                    .frame(minHeight: 110)
                    .padding(6)
                    .scrollContentBackground(.hidden)
                    .background(DSColors.inputBackground)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(DSColors.border, lineWidth: 1)
                    }
            }

        case .checkbox:

            VStack(alignment: .leading, spacing: DSSpacing.small) {

                DSCheckbox(
                    isChecked: Binding(
                        get: {
                            binding.wrappedValue == "true"
                        },
                        set: { newValue in
                            binding.wrappedValue = newValue ? "true" : "false"
                            viewModel.validateOnBlur(field.name)
                        }
                    ),
                    title: field.label
                )

                if let error = viewModel.errors[field.name] {

                    Text(error)
                        .font(DSTypography.caption)
                        .foregroundStyle(DSColors.error)
                }
            }
        }
    }

    // MARK: - Submission Result

    private func submittedValuesView(
        _ values: [String: String]
    ) -> some View {

        VStack(alignment: .leading, spacing: DSSpacing.medium) {

            Text("Form Submitted Successfully!")
                .font(DSTypography.subheading)
                .foregroundStyle(DSColors.success)

            ForEach(viewModel.config) { field in

                if let value = values[field.name] {

                    HStack(alignment: .top) {

                        Text(field.label)
                            .fontWeight(.semibold)

                        Spacer()

                        Text(
                            field.type == .checkbox
                                ? (value == "true" ? "Yes" : "No")
                                : value
                        )
                    }
                    .font(DSTypography.body)
                }
            }
        }
        .padding(DSSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DSColors.inputBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    LeadFormView()
}
