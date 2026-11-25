//
//  LeadFormConfiguration.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//

import Foundation

enum LeadFormConfiguration {

    static let fields: [FormField] = [

        FormField(
            name: "fullName",
            type: .text,
            label: "Full Name",
            placeholder: "Enter your full name",
            validations: [.required]
        ),

        FormField(
            name: "email",
            type: .email,
            label: "Email",
            placeholder: "Enter your email",
            validations: [.required, .email]
        ),

        FormField(
            name: "leadType",
            type: .select,
            label: "Lead Type",
            placeholder: "Select lead type",
            options: ["Individual", "Company"],
            validations: [.required]
        ),

        FormField(
            name: "companyName",
            type: .text,
            label: "Company Name",
            placeholder: "Enter company name",
            validations: [.required],
            visibility: .whenEquals(
                field: "leadType",
                value: "Company"
            )
        ),

        FormField(
            name: "phone",
            type: .text,
            label: "Phone",
            placeholder: "Enter 10-digit phone number",
            validations: [.required, .exactDigits(10)]
        ),

        FormField(
            name: "notes",
            type: .textarea,
            label: "Notes",
            placeholder: "Enter your notes",
            hint: "Maximum 200 characters",
            validations: [.maxLength(200)]
        ),

        FormField(
            name: "consent",
            type: .checkbox,
            label: "I agree to the terms and conditions",
            validations: [.required]
        )
    ]
}
