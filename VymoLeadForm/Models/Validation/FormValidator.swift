//
//  FormValidator.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//

import Foundation

enum FormValidator {

    // Validate all visible fields
    static func validate(
        config: [FormField],
        values: [String: String]
    ) -> [String: String] {

        var errors: [String: String] = [:]

        for field in config {

            // Skip fields that are currently hidden
            guard isVisible(field, values: values) else {
                continue
            }

            if let error = validateField(field, value: values[field.name] ?? "") {
                errors[field.name] = error
            }
        }

        return errors
    }

    // Validate one field
    static func validateField(
        _ field: FormField,
        value: String
    ) -> String? {

        for rule in field.validations {

            switch rule {

            case .required:

                if field.type == .checkbox {
                    if value != "true" {
                        return "This field is required."
                    }
                } else if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return "This field is required."
                }

            case .email:

                // Avoid showing an email error when the field is empty.
                if !value.isEmpty {
                    let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

                    if value.range(
                        of: pattern,
                        options: .regularExpression
                    ) == nil {
                        return "Please enter a valid email address."
                    }
                }

            case .exactDigits(let count):

                if !value.isEmpty {
                    let isValid = value.count == count &&
                        value.allSatisfy { $0.isASCII && $0.isNumber }

                    if !isValid {
                        return "Please enter exactly \(count) digits."
                    }
                }

            case .maxLength(let limit):

                if value.count > limit {
                    return "Maximum \(limit) characters allowed."
                }
            }
        }

        return nil
    }

    // Checking whether a field should be displayed
    static func isVisible(
        _ field: FormField,
        values: [String: String]
    ) -> Bool {

        switch field.visibility {

        case .always:
            return true

        case .whenEquals(let name, let expectedValue):
            return values[name] == expectedValue
        }
    }
}
