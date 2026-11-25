//
//  LeadFormViewModel.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//


import Foundation
import Combine

@MainActor
final class LeadFormViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let config: [FormField]
    
    @Published var values: [String: String] = [:]
    
    @Published var errors: [String: String] = [:]
    
    @Published var submittedValues: [String: String]? = nil
    
    // MARK: - Initialization
    
    init(config: [FormField] = LeadFormConfiguration.fields) {
        
        self.config = config
        
        // Initializing default values for every field
        for field in config {
            if field.type == .checkbox {
                values[field.name] = "false"
            } else {
                values[field.name] = ""
            }
        }
    }
    
    // MARK: - Update Field Value
    
    
    func updateValue(for fieldName: String, value: String) {
        
        if fieldName == "phone" {
            let digits = value.filter { $0.isASCII && $0.isNumber }
            values[fieldName] = String(digits.prefix(10))
            
        } else if fieldName == "notes" {
            values[fieldName] = String(value.prefix(200))
        } else {
            values[fieldName] = value
        }
        submittedValues = nil
        if fieldName == "leadType" && value != "Company" {
            values["companyName"] = ""
            errors["companyName"] = nil
        }
    }
    
    // MARK: - Field Visibility
    
    func isFieldVisible(_ field: FormField) -> Bool {
        
        return FormValidator.isVisible(
            field,
            values: values
        )
    }
    
    // MARK: - Validate on Blur
    
    func validateOnBlur(_ fieldName: String) {
        
        guard let field = config.first(where: {
            $0.name == fieldName
        }) else {
            return
        }
        
        guard isFieldVisible(field) else {
            errors[fieldName] = nil
            return
        }
        
        let value = values[fieldName] ?? ""
        
        if let error = FormValidator.validateField(
            field,
            value: value
        ) {
            errors[fieldName] = error
        } else {
            errors[fieldName] = nil
        }
    }
    
    // MARK: - Submit Form
    
    func submitForm() {
    
        errors = FormValidator.validate(
            config: config,
            values: values
        )
        
        // Stop submission if errors exist
        guard errors.isEmpty else {
            submittedValues = nil
            return
        }
        
        // Store only visible field values
        var result: [String: String] = [:]
        
        for field in config where isFieldVisible(field) {
            result[field.name] = values[field.name] ?? ""
        }
        
        submittedValues = result
    }
}
