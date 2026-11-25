# Vymo Lead Capture Form – iOS

A dynamic Lead Capture Form built using **Swift, SwiftUI, MVVM, and a reusable SwiftUI Design System**.

The application renders form fields dynamically from a configuration array, supports field-level validation, conditional field visibility, and responsive layouts for iPhone and iPad.

## 1. Technology Stack

- Swift
- SwiftUI
- MVVM Architecture
- Swift Package Manager (SPM)
- Local Swift Package – VymoDesignSystem
- iOS 17+

No third-party UI or form libraries are used.

## 2. Features

- Dynamic form rendering using configuration.
- Supports Text, Email, Select, Textarea, and Checkbox fields.
- Conditional visibility of Company Name based on Lead Type.
- Reusable design system components.
- Field-level validation on blur and form submission.
- Required field validation.
- Email format validation.
- Phone number validation (exactly 10 digits).
- Notes character limit (200 characters).
- Displays validation errors below the corresponding fields.
- Prevents form submission when validation errors exist.
- Displays submitted form values on successful submission.
- Responsive layout:
  - Single-column layout on compact iPhone screens.
  - Two-column layout on wider screens.
  - Notes and Consent span the full width in the two-column layout.
- Keyboard-aware scrolling to keep focused fields accessible.

## 3. Project Structure

```text
VymoLeadForm/
│
├── README.md
│
├── VymoLeadForm/
│   ├── Models/
│   │   ├── FieldType.swift
│   │   ├── FormField.swift
│   │   ├── LeadFormConfiguration.swift
│   │   └── Validation/
│   │       └── FormValidator.swift
│   │
│   ├── ViewModels/
│   │   └── LeadFormViewModel.swift
│   │
│   └── Views/
│       ├── ContentView.swift
│       └── LeadFormView.swift
│
└── VymoDesignSystem/
    ├── Package.swift
    └── Sources/
        └── VymoDesignSystem/
            ├── Tokens/
            │   ├── DSColors.swift
            │   ├── DSSpacing.swift
            │   ├── DSTypography.swift
            │   └── DSLayout.swift
            │
            └── Components/
                ├── DSInputField.swift
                ├── DSSelectField.swift
                ├── DSCheckbox.swift
                ├── DSButton.swift
                └── DSFieldView.swift
```

## 4. Design System – VymoDesignSystem

The reusable design system is maintained as a separate local Swift Package.

It is independent of the Lead Form feature and contains reusable UI components and design tokens.

### Design Tokens

Located in:

`VymoDesignSystem/Sources/VymoDesignSystem/Tokens/`

- **DSColors.swift:** Defines primary, background, text, border, error, and success colors.
- **DSSpacing.swift:** Defines reusable spacing values.
- **DSTypography.swift:** Defines heading, subheading, body, caption, and button typography.
- **DSLayout.swift:** Defines the breakpoint for switching to a two-column layout.

### Reusable Components (Atoms)

Located in:

`VymoDesignSystem/Sources/VymoDesignSystem/Components/`

- **DSInputField:** Reusable text input component.
- **DSSelectField:** Reusable selection component.
- **DSCheckbox:** Reusable checkbox component.
- **DSButton:** Reusable button component.
- **DSFieldView:** Field wrapper that displays a label, control, hint, and validation error.

The components are designed to be reusable across different features without depending on lead-specific business logic.

## 5. Dynamic Form Configuration

Located in:

`VymoLeadForm/Models/LeadFormConfiguration.swift`

The form fields are defined using a configuration array.

Each field contains:

- Name
- Type
- Label
- Placeholder
- Hint
- Options (for select fields)
- Validation rules
- Visibility conditions

The main form screen iterates through this configuration and renders the appropriate SwiftUI component based on the field type.

Adding a new supported field requires adding a configuration entry rather than creating a separate input view in the main screen.

## 6. Validation Logic

Located in:

`VymoLeadForm/Models/Validation/FormValidator.swift`

Validation is maintained separately from the SwiftUI views.

The `FormValidator` takes the form configuration and current field values and returns a dictionary of validation errors.

Supported validation rules:

- Required field validation.
- Email format validation.
- Exact digit count validation.
- Maximum character length validation.

Conditional visibility is also considered during validation. Hidden fields are skipped.

For example, Company Name is required only when Lead Type is set to Company.

Validation is performed on field blur and form submission.

## 7. MVVM Architecture

The application follows the Model-View-ViewModel architecture.

### Model

Contains the form data structures and configuration:

- `FieldType.swift`
- `FormField.swift`
- `LeadFormConfiguration.swift`
- `FormValidator.swift`

### ViewModel

Located in:

`VymoLeadForm/ViewModels/LeadFormViewModel.swift`

The `LeadFormViewModel` manages:

- Form field values.
- Validation errors.
- Field visibility.
- User input updates.
- Validation on blur.
- Form submission.
- Submitted values.

It uses `ObservableObject` and `@Published` properties to update the SwiftUI views whenever the form state changes.

### View

Located in:

`VymoLeadForm/Views/`

- `ContentView.swift`: Welcome screen and navigation to the lead form.
- `LeadFormView.swift`: Dynamic form rendering, responsive layout, user interactions, and submission result display.

The views observe the ViewModel and use reusable components from the design system.

## 8. Responsive Layout

Responsive layout is implemented in:

`VymoLeadForm/Views/LeadFormView.swift`

The layout uses `GeometryReader`, `LazyVGrid`, and the breakpoint defined in `DSLayout.swift`.

### Compact Layout

- Single-column layout.
- Full-width input fields.
- Scrollable form content.
- Focused fields are brought into view when the keyboard appears.
- Submit button is placed using `safeAreaInset`.

### Regular / Wide Layout

- Two-column grid layout.
- Full Name and Email share a row.
- Notes and Consent span both columns.
- Form content is centered with a maximum width to avoid excessively wide fields.

## 9. Local Swift Package Integration

The `VymoDesignSystem` package is integrated into the main iOS application using Swift Package Manager.

To add the local package in Xcode:

1. Open the VymoLeadForm project in Xcode.
2. Select **File → Add Package Dependencies**.
3. Choose **Add Local**.
4. Select the `VymoDesignSystem` folder containing `Package.swift`.
5. Add the `VymoDesignSystem` library product to the application target.
6. Import the package wherever its components are required:

```swift
import SwiftUI
import VymoDesignSystem
```

The package can be reused by other iOS features or projects without depending on the Lead Form implementation.

## 10. Installation and Running

### Requirements

- macOS with Xcode installed.
- Xcode 15 or later.
- iOS 17+ Simulator or physical device.

### Steps

1. Clone or download the project repository.
2. Open `VymoLeadForm.xcodeproj` in Xcode.
3. Ensure the local `VymoDesignSystem` package is resolved.
4. Select an iOS Simulator (for example, iPhone SE or iPhone 16).
5. Build and run the application using **Command + R**.

### Testing Responsive Layout

Test the application using:

- iPhone SE or another narrow iPhone simulator for compact layout.
- iPad simulator or a wide window for regular layout.
- Different keyboard types and focused fields.
- Both Individual and Company lead types.

## 11. Scope

This implementation focuses on dynamic form rendering, reusable UI components, validation, MVVM architecture, and responsive design.

Backend integration, authentication, database persistence, and additional form controls are outside the scope of this assignment.

---

**Developed using Swift, SwiftUI, MVVM, and a reusable local Swift Package.**
