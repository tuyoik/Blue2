import SwiftUI

struct ChatMenuView: View {
    @State private var searchText = ""
    @State private var showNewChatView = false
    @State private var selectedTab = 1 // 1 for Chats, 0 for Home, 2 for Favourites, 3 for Activities

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)

                ChatsView(searchText: $searchText, showNewChatView: $showNewChatView)
                    .tabItem {
                        Label("Chats", systemImage: "message")
                    }
                    .tag(1)

                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                    .tag(2)

                ActivitiesView()
                    .tabItem {
                        Label("Activities", systemImage: "leaf")
                    }
                    .tag(3)
            }
            .accentColor(.blue)
        }
    }
}

struct ChatsView: View {
    @Binding var searchText: String
    @Binding var showNewChatView: Bool
    
    @State private var groups: [String] = ["family of hamsters", "random grass group", "rat chat 123"]
    @State private var availableGroups: [String] = ["Cat Clan", "Bird Nest", "Fish Tank", "Fish", "Racoon"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                List(groups, id: \.self) { group in
                    NavigationLink(destination: ChatRoomView(
                        groupName: group,
                        onLeaveGroup: { leaveGroup(group) }
                    )) {
                        ChatRow(
                            imageName: getImageName(for: group),
                            groupName: group,
                            lastMessage: getLastMessage(for: group),
                            unreadCount: getUnreadCount(for: group),
                            time: "11:45"
                        )
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Chats")
            .toolbar {
                Button(action: {
                    showNewChatView = true
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewChatView) {
                Text("New Chat View Content") // Placeholder
            }
        }
    }
    
    // Helper functions to maintain compatibility with existing chat data
    private func getImageName(for group: String) -> String {
        switch group {
        case "family of hamsters": return "hamsterImage"
        case "random grass group": return "grassImage"
        case "rat chat 123": return "ratImage"
        default: return "defaultImage"
        }
    }
    
    private func getLastMessage(for group: String) -> String {
        switch group {
        case "family of hamsters": return "Pink Koala: Hey how are we today?"
        case "random grass group": return "You: 🎤 Voice"
        case "rat chat 123": return "Kieron: @adam check it"
        default: return "No messages yet"
        }
    }
    
    private func getUnreadCount(for group: String) -> Int {
        switch group {
        case "family of hamsters": return 99
        case "random grass group": return 0
        case "rat chat 123": return 3
        default: return 0
        }
    }
    
    func leaveGroup(_ group: String) {
        if let index = groups.firstIndex(of: group) {
            groups.remove(at: index)
        }

        if let newGroup = availableGroups.randomElement() {
            availableGroups.removeAll { $0 == newGroup }
            groups.append(newGroup)
        }
    }
}

struct ChatRoomView: View {
    let groupName: String
    let onLeaveGroup: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var messages: [String] = []
    @State private var newMessage: String = ""
    @State private var showLeaveAlert = false

    var body: some View {
        VStack {
            List(messages, id: \.self) { message in
                HStack {
                    Text(message)
                        .padding(10)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .listStyle(PlainListStyle())

            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle(groupName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showLeaveAlert = true
                }) {
                    Text("Leave Group")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
            }
        }
        .alert("Are you sure?", isPresented: $showLeaveAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Leave", role: .destructive) {
                onLeaveGroup()
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Do you really want to leave the group?")
        }
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(newMessage)
        newMessage = ""
    }
}

struct ChatRow: View {
    let imageName: String
    let groupName: String
    let lastMessage: String
    let unreadCount: Int
    let time: String
    var hasMentions: Bool = false

    var body: some View {
        HStack {
            // Support both image and placeholder
            if UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 50, height: 50)
                    .overlay(Text(groupName.prefix(1)))
            }

            VStack(alignment: .leading) {
                Text(groupName)
                    .font(.headline)
                HStack {
                    if hasMentions {
                        Image(systemName: "at")
                    }
                    Text(lastMessage)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
                if unreadCount > 0 {
                    Text("\(unreadCount)")
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// Placeholder Views
struct HomeView: View { var body: some View { Text("Home") } }
struct FavouritesView: View { var body: some View { Text("Favourites") } }
struct ActivitiesView: View { var body: some View { Text("Activities") } }

struct ChatMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMenuView()
    }
}
