//
//  ContentView.swift
//  VymoLeadForm
//
//  Created by Aneesha P A on 24/11/26.
//


import SwiftUI
import VymoDesignSystem

struct ContentView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Image("vymo_logo")
                    .resizable()
                       .scaledToFit()
                       .frame(width: 120, height: 120)
                       .clipShape(RoundedRectangle(cornerRadius: 20))

                Text("Welcome to Vymo")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Lead Registration System")
                    .font(.body)
                    .foregroundStyle(.secondary)

                NavigationLink(destination: LeadFormView()) {
                    Text("Register Now")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(DSColors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 30)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
