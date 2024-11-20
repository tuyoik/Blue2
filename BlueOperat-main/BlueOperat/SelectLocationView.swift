//
//  SelectLocationView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

public struct SelectLocationView: View {
    @State private var selectedLocation: String? = nil
    let locations = [
        "Sydney", "Melbourne", "Canberra", "Brisbane",
        "Gold Coast", "Hobart", "Perth", "Darwin",
        "Adelaide", "Newcastle"
    ]
    
    // Use @Environment to access the presentation mode for navigation
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Where are you located?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("(Choose 1 only)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    ForEach(locations, id: \.self) { location in
                        Button(action: { selectedLocation = location }) {
                            Text(location)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(selectedLocation == location ? .white : .black)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(selectedLocation == location ? Color.theme : Color.theme.opacity(0.2))
                                .cornerRadius(30)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.theme)
                    .frame(width: 20, height: 8)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            // NavigationLink to SelectActivitiesView
            NavigationLink(destination: SelectActivitiesView()) {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color.theme)
            .cornerRadius(30)
            .padding(.horizontal, 40)
            
            Button(action: {
                // Dismiss the current view to go back
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .font(.system(size: 16))
                    .foregroundColor(Color.subText)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true) // Hide default back button
    }
}

#Preview {
    SelectLocationView()
}
