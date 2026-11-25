//
//  FormField.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//


import Foundation

enum ValidationRule {
    case required
    case email
    case exactDigits(Int)
    case maxLength(Int)
}

enum FieldVisibility {
    case always
    case whenEquals(field: String, value: String)
}

struct FormField: Identifiable {
    let name: String
    let type: FieldType
    let label: String
    var placeholder: String = ""
    var hint: String? = nil
    var options: [String] = []
    var validations: [ValidationRule] = []
    var visibility: FieldVisibility = .always

    var id: String { name }
}

