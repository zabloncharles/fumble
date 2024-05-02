//
//  ChatsView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/20/23.
//

//
//  Walls.swift
//  Fusion
//
//  Created by Zablon Charles on 2/20/22.
//

import SwiftUI


struct ChatsView: View {
    @Binding var profiles: [UserStruct]
    @State var profile = fakeUsers[0]
    @State var currentUser: UserStruct? = fakeUser
    @State var userScrolledDown : Bool = false
    @AppStorage("hidemainTab") var hidemainTab = false
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var showMessages = false
    @State var showProfile = false
    @State var userAvatarsLoaded = false
    @State var appear = [false, false, false]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var pageAppeared = false
    @State private var chatMessages: [MessageModel] = []
    @State var currentViewed = ""
    @State var texter = ""
    @Binding var likedEmails: [String]
    @Binding var dislikedEmails: [String]
    @State private var xOffset: CGFloat = 0
    @AppStorage("currentPage") var selected = 0
    //  @State var fakeincomingMessages = IncomingMessage(name: "", text: "", timestamp: "")
    
    var body: some View {
        ZStack {
                VStack {
                    DynamicTopBar(label: "chats", labelicon: "bubble.left.and.bubble.right",trailinglabel: "\(profiles.count)",trailinglabelicon: "", notification: true){
                        
                    }
                    .background{
                        ScrollDetectionView(userScrolledDown: $userScrolledDown)
                    }
                    ScrollView(showsIndicators: false) {
                       
                        navandmessages
                    }
                    .coordinateSpace(name: "scroll")
                    .background(BackgroundView())
                  
                }
                
            if !profiles.isEmpty && !showMessages {
                gettingmessages
                    .transition(.opacity)
            }
        }.onAppear{
       
            hidemainTab = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.spring()){
                        if userAvatarsLoaded {
                            showMessages = true
                        }
                }
                
            }
        }
        .onDisappear{
            withAnimation(.spring()){
                pageAppeared = false
            }
        }
    }
    
    var navandmessages: some View {
        VStack {
                sectionsSection
            
                .padding(.bottom, 30)
//                .offset(y: !showMessages ? UIScreen.main.bounds.height  : 0)
                
        }
    }
    
    
    var sectionsSection: some View {
        
        VStack(spacing: 10) {
            if !profiles.isEmpty {
                ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in

                    NavigationLink(destination:
                                    MessageDetailView(log: user)
                    ) {
                        VStack {
                            MessageCard(section: user, profile: $profile, showProfile: $showProfile, userAvatarLoaded: $userAvatarsLoaded, profiles:$profiles, index:index, dislikedEmails:$dislikedEmails)
                           
                        }
                    }
                }
            } else {
                nomessages
            }
        }
       
        .padding(.horizontal,10)
        .padding(.top, 5)
        .padding(.bottom,40)
        
    }
    var gettingmessages: some View {
        VStack {
            Spacer()
            VStack(alignment: .center) {
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                   
            }
          
            VStack(alignment: .center, spacing: 20.0) {
                
                Text("Getting your messages")
                    .font(.headline)
                Text("Oops well this is embarrassing. Making sure we have every message, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text("Just a second :)")
                        .font(.body)
                        .fontWeight(.semibold)
                }.padding(.horizontal,15)
                    .padding(.vertical,10)
                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                    .cornerRadius(30)
            }.padding(10)
                
//                .offset(y: showMessages ? UIScreen.main.bounds.height *  1.02 : 0)
            Spacer()
        }
    }
    var nomessages: some View {
        VStack {
//            VStack {
//                LottieView(filename: "loveflying" ,loop: true)
//                    .frame(width: 100, height: 150)
//
//
//            }.offset( x:-40, y:280)
//                .opacity(0.7)
            
            
                LottieView(filename: "sadheart" ,loop: true)
                    .frame(width: 280, height: 180)
                
                
            
            
            VStack(alignment: .center, spacing: 20.0) {
                
                Text("Opps! No messages yet")
                    .font(.headline)
                Text("Nothing to seee here. Messages are more intentional on Fumble so don't worry, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text("Try adjusting preferences")
                        .font(.body)
                        .fontWeight(.semibold)
                }.padding(.horizontal,15)
                    .padding(.vertical,10)
                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                    .cornerRadius(30)
                    .neoButton(isToggle: false) {
                        selected = 4
                    }
            }.padding(10)
//                .opacity(pageAppeared ? 1 : 0)
        }.offset(y:130)
    }
    var filteredProfiles: [UserStruct] {
        guard let currentUser = currentUser
        else {
            return profiles
        }
        let matchingEmails = Set(currentUser.matched)
        return profiles.filter { !matchingEmails.contains($0.email) }
    }
    func close() {
        withAnimation {
            viewState = .zero
        }
        
    }
    
  
   
}



struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
        
        
    }
    }
