import SwiftUI

public struct CongratulationView: View {
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack(spacing: 16) {
            Spacer() // Push content towards the center
            Text("Congratulations!")
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
                .padding(.top, 20)
            
            // Add image
            Image("Congratulation")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.horizontal, 40)
            
            Text("We’ve found 3 chats for you!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme)
                .padding(.top, 10)
            
            Text("Start now to make new friends!")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text("You should reply in 24 hours to remain being a part of your group")
                .font(.system(size: 16))
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // Navigation Link to ChatMenuView
            NavigationLink(destination: ChatMenuView()) {
                Text("Start Chat")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.button) // Blue button color
            .cornerRadius(30)
            .padding(.horizontal, 40) // Center the button
            
            // Custom Back button below Next button
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Go back to the previous screen
            }) {
                Text("Back")
                    .font(.system(size: 16))
                    .foregroundColor(Color.subText)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true) // Hide the default back button on the top left
    }
}

#Preview {
    CongratulationView()
}
