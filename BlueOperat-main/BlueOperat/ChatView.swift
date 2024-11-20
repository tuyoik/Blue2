import SwiftUI

struct ChatView: View {
    let groupName: String
    let members: Int

    @State private var messages: [ChatMessage] = [
        ChatMessage(sender: "Random Robert", text: "Hi 😩😩😩😐", timestamp: "10:02", reactions: ["😎", "🖥"], reactionCounts: [1, 4]), // Split reactions and counts
        ChatMessage(sender: "Blue Quokka", text: "This is awkward.... 😬", timestamp: "10:08", reactions: ["👍"], reactionCounts: [4]),
        ChatMessage(sender: "Anonymous", text: "Um 🤔", timestamp: "10:06"),
        ChatMessage(sender: "Anonymous", text: "@ratbot Give us an icebreaker please!", timestamp: "10:12"),
        // Deleted message omitted (handle this in ChatMessage view if needed)
        ChatMessage(sender: "Ratbot", text: "Icebreaker time! Tell us one of your most favourite spots in Australia and why!", timestamp: "10:08", reactions: ["👍"], reactionCounts: [4]),
        ChatMessage(sender: "Ratbot", text: "I'll go first! Mine is Sydney Park!", timestamp: "10:06")
    ]

    @State private var newMessageText = ""



    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(messages) { message in
                        ChatMessageView(message: message)
                    }
                }
                .listStyle(.plain) // Important for proper spacing

                HStack {
                    TextField("Type a message...", text: $newMessageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button(action: {
                        // Send message action
                    }) {
                        Image(systemName: "paperplane.fill")
                    }
                    .padding(.trailing)
                }

            }
            .navigationTitle("\(groupName)  \(members) members")
             .navigationBarTitleDisplayMode(.inline)


        }
    }
}




struct ChatMessage: Identifiable, Hashable {
    let id = UUID()
    let sender: String
    let text: String
    let timestamp: String
    var reactions: [String] = [] // Array of reaction emojis
    var reactionCounts: [Int] = []  // Corresponding counts for each reaction


    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Hash based on the ID for uniqueness
    }

    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.id == rhs.id // Compare based on ID
    }
}




struct ChatMessageView: View {
    var message: ChatMessage


    var body: some View {
        HStack {

            if message.sender == "Ratbot" {
                Image("rat") // Your rat image name here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

            } else if message.sender == "Random Robert" {

                Image(systemName: "person.circle.fill")
                                        .font(.system(size: 30))


            } else {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 30))


            }


            VStack(alignment: .leading) { // Align text to the leading edge
                Text(message.sender)
                    .font(.headline)


                HStack { // Put Text and timestamp in same line
                        Text(message.text)
                        Spacer()  // Push the timestamp to the right

                               Text(message.timestamp)

                                   .font(.caption)
                                   .foregroundColor(.gray)
                           }


                if !message.reactions.isEmpty { // Check if there are reactions
                    HStack {
                        ForEach(0..<message.reactions.count, id: \.self) { index in
                            HStack{
                                Text(message.reactions[index])
                                Text(String(message.reactionCounts[index]))
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 5) // Add some vertical padding
    }
}




#Preview {
    ChatView(groupName: "Rats", members: 6)
}
