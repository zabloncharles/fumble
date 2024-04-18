//
//  SkullProfile.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//

import SwiftUI


struct SkullProfile: View {
    @State  var previousOffset: CGFloat = 0
    @State var showblacknav = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @AppStorage("hidemainTab") var hidemainTab = false
    var profile = userStruct[0]
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var pageAppeared = false
    @Binding var showProfile : Bool
    @FocusState var sendMessageFocused: Bool
    @State var profileImagesLoaded = [false,false,false]
    @State var showHearts = false
    @State var text = ""
    @State var erro = ""
    @State var sendMessage = ""
    @State var typeText = ""
    @State var dislike = false
    @State var animateMatchImage = false
    @State var animateapper = false
    @State var profileLoaded = false
    @State var outOfMatches = false
    @State var animategirl = false
    @State var liked = false
    @State var likedtext = false
    @State var likedquote = "I enjoy playing the zumba"
    @State var cancelLike = false
    @State var profileImages = ["","",""]
    @State var likedImageUrl = ""
    @State var report = false
    @State var showMore = false
    @State var hidenav = false
    @State var scrolledItem = 0
    @State var profileNumber = 0
    @Binding var currentIndex : Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
          
            
          
          
            
            VStack {
                if !outOfMatches && dislike {
                    VStack {
                        LottieView(filename: "girlonphone")
                            .neoButton(isToggle: false) {
                                //
                            }
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    
                                    dislike = false
                                    animategirl = false
                                    
                                    
                                }
                            }
                            .offset(y:-30)
                    }
                    .frame(width: 350, height: 350)
                    .animation(.spring(), value: animategirl)
                    .scaleEffect(animategirl ? 1 : 0.81)
                    .overlay(
                        VStack{
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Looking for your soulmate..")
                            }
                        }.padding()
                            .offset(y:-20)
                    )
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                animategirl = true
                            }
                        }
                    }
                }
            }
            
           
                ZStack {
                    

                    ScrollView {
                        
//                        cover
//                            .background(scrollDetection)
                          
                     
                        content
                            .background(scrollDetection)
                          
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                    .scaleEffect(-viewState.width/500 + 1)
                    .onAppear{
                        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        profileNumber = profileNumber + 1
                    }
                    .blur(radius: liked ? 10 : 0)
                    .onTapGesture {
                        
                        
                        
                    }
                    .ignoresSafeArea()
                    
                    //the send text view that comes after liking a potential match
                   
                
                    if liked {
                        likedcontent
                            .transition(.offset(y:UIScreen.main.bounds.height))
                            
                    }
                           

                  
                                      
                      
                    
                            
                      
                    
                }.animation(.spring(), value: dislike)
               
            nameandheartnav
                .opacity(liked ? 0 : currentUser?.email == profile.email ? 0 : 1)
            
           
            
            if likedtext {
                likedcontent
                    .transition(.offset(y:UIScreen.main.bounds.height))
                
            }
            
            if report {
              ReportCard(report: $report, appeared: $hidemainTab)
            }
             
            
              
            
        }.background(Color("offwhiteneo"))
        .onAppear{
            withAnimation(.spring()) {
                animateapper = true
            }
        }
        .onDisappear{
            withAnimation(.spring()) {
                animateapper = false
                
            }
        }
        .onChange(of: liked) { V in
            if liked {
                hidemainTab = true
                withAnimation(.spring()) {
                    showHearts = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showHearts = false
                    }
                }
            } else {
                likedquote = ""
                hidemainTab = false
            }
        }
        
    }
    var nameandheart: some View{
       
            HStack {
                HStack(spacing: 3.0) {
                    
                
                   
                    Text(currentUser?.email == profile.email ? "Profile" : "Match")
                            .font(.title)
                        .bold()
                
                    
                    Image(systemName:currentUser?.email == profile.email ?  "person.crop.circle" : "person.2")
                        .font(.title)
                        .fontWeight(.bold)
                        
                    
                    
                 
                    
                    
                }
                    .padding(.vertical, 6)
                 
                
                 
                    
                
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        showProfile = false
                    }
                    withAnimation {
                       // if currentIndex != profiles.count - 1 {
                            currentIndex += 1
                       // }
                        
                    }
                
                    
                } label: {
                    if !liked {
                        Image(systemName:currentUser?.email == profile.email ?  "gear" : "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(currentUser?.email == profile.email ?  Color("black") : .red)
                    } else {
                        
                        Image(systemName: "heart.slash.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                }
               
                
            }.padding(.horizontal,25)
            .padding(.top,5)
           
        
           
       
    }
    var nameandheartnav: some View{
        VStack {
            HStack {
                HStack {
                    
                    
                    HStack(spacing: 2){
                        Text(profile.firstname)
                            .bold()
                            .font(.title)
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        
                        
                    }
                    
                    
                    
                }
                    .padding(.vertical, 6)
                    .background(Color("offwhiteneo"))
                  
                   
                
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        showProfile = false
                    }
                  
                    showblacknav = true
                    withAnimation {
                        // if currentIndex != profiles.count - 1 {
                  
                        currentIndex += 1
                        
                        // }
                        
                    }
                    
                    
                } label: {
                    if !dislike {
                        Image(systemName: "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    } else {
                        
                        LottieView(filename: "heartbeat")
                            .frame(width: 99, height: 50)
                            .offset(x:30)
                            .opacity(0.57)
                        
                    }
                    
                    
                }
            } .offset(y:69)
                .padding(.horizontal,25)
                
                .frame(height: 190)
                
                .background(Color("offwhiteneo"))
                .offset(y:-100)
            Spacer()
        }
        .animation(.spring(), value: showblacknav)
        .opacity(showblacknav ? 1 : 0)
        .offset(y: showblacknav ? 0 : -100)
      
    }
  
    var avatarandthreeinfo: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.angularGradient(colors: [.purple, .orange, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                        .frame(height: 95)
                        .frame(width: 95)
                        .cornerRadius(64)
                    GetImageAndUrl(url:profile.avatar, loaded: .constant(true), imageUrl: .constant(""))
                    
                        .frame(height: 91)
                        .frame(width: 91)
                        .cornerRadius(64)
                        .overlay(
                            Text("Active")
                                .font(.caption)
                                .padding(.horizontal,5)
                                .padding(.vertical,2)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .offset(x:30,y:30)
                        )
                }
                .padding(.horizontal,5)
                .padding(.bottom,-20)
                
                Spacer()
                
                VStack {
                    HStack{
                        
                        VStack{
                            Image(systemName: "balloon.fill")
                            Text("24")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        
                        
                        
                        
                        VStack{
                            Spacer()
                        }.frame(width: 1, height: 12)
                            .background(Color("black"))
                        
                        VStack{
                            Image(systemName: "figure.cooldown")
                            
                            Text("5'6")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                       
                        
                        VStack{
                            Spacer()
                        }.frame(width: 1, height: 12)
                            .background(Color("black"))
                        
                        VStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("1,200M")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        
                    }
                    
                    
                    if (currentUser?.email == profile.email){
                    HStack{
                        Spacer()
                        Text("Edit Profile")
                            .foregroundColor(Color("white"))
                           
                        Spacer()
                    }.background(.blue)
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                        .background(.blue)
                        .cornerRadius(6)
                        .padding(.horizontal,70)
                    }
                }
                
               
                
                Spacer()
            }
            Spacer()
            
            VStack {
                HStack(spacing: 2){
                    Text(profile.firstname)
                        .bold()
                        .font(.headline)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 18, weight: .medium))
                    Text("her/she")
                       
                        .font(.callout)
                    Spacer()
                }
                HStack{
//                    text characters of 131
                    Text("\"Music lover and hopeless romantic. Enjoy quiet nights in with a good book or movie, but also love hitting the dance floor and losing myself in the music.\"")
                        .font(.subheadline)
                        .lineLimit(3)
                    Spacer()
                }
               
            } .padding(.top,20)
        }.padding(.leading,20)
    }
    
    var moreinfohorizontalcards: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
               
                InfoButton(icon: "graduationcap", label: profile.education)
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                InfoButton(icon: "building", label: profile.work)
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                   
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                InfoButton(icon: "location", label: profile.location[0])
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                
                  
                
            
            }.padding(.trailing,20)
            .padding(.leading,20)
            
          
            
        }
    }
    var whatilike: some View{
        QuotePillsCard(name: profile.firstname, caption: profile.lifestyledesc,report: $report)
            .neoDoubleTapButton(isToggle: false, perform: {
                likedImageUrl = ""
               
                withAnimation(.spring()) {
                    liked = true
                }
                likedquote = profile.lifestyledesc
               
            })
            .padding(.leading,20)
         
    }
    var content: some View {
        
      
            
            
            
            
            VStack(alignment: .leading, spacing: 20.0) {
                
                nameandheart
             
                
               avatarandthreeinfo
                   
                 
               
                
                
//                About me card
                VStack(alignment: .leading, spacing: 13.0) {
                    
                   
                        moreinfohorizontalcards
                       
                    
                        Divider()
                     
                    
                       
                        
                    QuoteImageCard(name: profile.firstname, caption: "Life is too short to worry about thigh gaps, focus on making memories",url: profile.images[0], urlReturned: $profileImages[0], loaded: $profileImagesLoaded[0], report: $report)
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                           likedquote = "Life is too short to worry about thigh gaps, focus on making memories"
                            likedImageUrl = profileImages[0]
                            if profileImagesLoaded[0] {
                                withAnimation(.spring()) {
                                    liked = true
                                }
                            }
                            
                        })
                 
                   
//                    Likes Pill
                  whatilike
                    
                    Divider()
                    
                    QuoteImageCard(name: profile.firstname, caption: "Life's a beach, enjoy the waves and soak up the sun", url: profile.images[1], urlReturned: $profileImages[1], loaded: $profileImagesLoaded[1], report: $report)
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                            likedquote = "Life's a beach, enjoy the waves and soak up the sun"
                            likedImageUrl = profileImages[1]
                            
                            if profileImagesLoaded[1] {
                                withAnimation(.spring()) {
                                    liked = true
                                }
                            }
                            
                            
                        })
                    
                    
                   answerprompt
                    
                    
                    
                    
                    
                }
                
            }
            
            .padding(.top,40)
           
            .padding(.bottom,120)
            
        
    }
    
    var answerprompt: some View{
        QuoteAnswerCard(name: profile.firstname,day: "1",caption: "I'm a professional couch potato. Netflix marathons are my specialty!", question: "What do you do for fun?", report: $report)
            .padding(.leading,20)
            .neoDoubleTapButton(isToggle: false, perform: {
                likedImageUrl = ""
                
                withAnimation(.spring()) {
                    liked = true
                }
                likedquote = "I'm a professional couch potato. Netflix marathons are my specialty!"
            })
    }
    
    var outofmatchesView: some View {
        ZStack {
            
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset( x:-40, y:280)
                .opacity(0.7)
            
            VStack {
                LottieView(filename: "sadheart" ,loop: true)
                    .frame(width: 280)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset(y:-160)
            
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "figure.wave")
                        Text("No More Profiles!")
                        
                    }.font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image(systemName: "fleuron")
                        Text("Boost")
                    }.padding(.horizontal,12)
                        .padding(.vertical,5)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(20)
                    
                }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                    .offset(y: pageAppeared ? 0 : -300)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20.0) {
                    
                    Text("Come back later or adjust your preferences")
                        .font(.headline)
                    Text("Matches are carefully curated on Soulmate so don't worry, They'll come in very soon.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("Adjust My Preferences")
                            .font(.body)
                            .fontWeight(.semibold)
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                        .cornerRadius(30)
                        .neoButton(isToggle: false) {
                            //code
                            selected = 4
                        }
                }.padding(10)
                    .opacity(pageAppeared ? 1 : 0)
                
                
                
                Spacer()
            }.padding(20)
        }
        .onAppear{
          
            withAnimation(.spring().speed(0.4)){
                pageAppeared = true
            }
        }
        .onDisappear{
            
            withAnimation(.spring()){
                pageAppeared = false
            }
        }
    }
    
    var likedcontent: some View {
        
        VStack(spacing: 20.0) {
          
            Spacer()
            if showHearts {
                
                LottieView(filename: "loveflying")
                    .frame(width: 299, height: 250)
                    .colorMultiply(.white) 
                    .opacity(0.57)
                
            }
           
            HStack {
                
          
                
                
                HStack {
                    HStack(spacing:4) {
                        Text(profile.firstname)
                            .bold()
                            .font(.title2)
                       
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                    }
                    Text("2d")
                    
                        .font(.callout)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                }.padding(.horizontal,4)
                Spacer()
            }.offset(y:40)
           
            VStack(alignment: .leading) {
            
                
                    HStack {
                        if liked && !likedImageUrl.isEmpty {
                            Rectangle()
                                .fill(.gray)
                                .frame(width:1, height:30)
                        }
                        VStack {
                            
                            if liked && !likedImageUrl.isEmpty {
                                GetImageAndUrl(url:likedImageUrl, width: 40 , height: 40, loaded: .constant(true), imageUrl: .constant(likedImageUrl))
                                    .frame(width: 40 , height: 40)
                                    .onAppear {
                                        sendMessageFocused = true
                                    }
                            }
                            
                        }
                        .animation(.spring(), value: showblacknav)
                        
                        .cornerRadius(5)
                        HStack (spacing: 4.0){
                           
                            if likedImageUrl.isEmpty {
                                Image(systemName: "fleuron.fill")
                                    .foregroundColor(.red)
                            }
                            
                            Text(erro.isEmpty ? "You Liked :)" : erro)
                            Spacer()
                            if !likedImageUrl.isEmpty {
                                Image(systemName: "fleuron.fill")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        Spacer()
                        
                       
                           
                    }.font(.title3)
                        .fontWeight(.bold)
              
                    
                
                HStack(spacing: 6.0) {
                    Image(systemName: likedImageUrl.isEmpty ? "quote.opening" : "quote.opening")
                        .font(.callout)
                    
                    Text(likedquote)
                        .font(.callout)
                        .italic()
                        .multilineTextAlignment(.leading)
                        
                    
                }.padding(.top,0.3)
            }.padding(15)
//                .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
//                    //clikced you liked
//                    sendMessageFocused = false
//                })
                .background(Color("offwhiteneo"))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("black").opacity(0.50), lineWidth: 1)
                    
                )
                .padding(.top, 30)
                .offset(y: liked ? 5 : -20)
            
         
        
                TextField("Say Hi...", text: $sendMessage)
                
                    .focused($sendMessageFocused)
                    .padding(.vertical,16)
                    .padding(.leading, 15)
                    .foregroundColor(Color("black"))
                    .background(Color("offwhiteneo"))
                   
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("black").opacity(0.50), lineWidth: 1)
                        
                    )
                    .cornerRadius(30)
                    .overlay(
                        HStack {
                            Spacer()
                            HStack(spacing: 0.0) {
                                Image(systemName: "paperplane")
                              
                                
                            }    .padding(.vertical,12)
                                .padding(.horizontal,12)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(29)
                                .offset(x: -5)
                                .onTapGesture {
                               
                                }
                            
                        }
                    )
                    
                    .modifier(KeyboardAwareModifier())
                    
          
            
            
            
        }.padding(.horizontal, 10)
            .padding(.bottom,10)

            .background(Color("offwhite").opacity(0.02))
            .onTapGesture {
                withAnimation(.spring()) {
                    liked = false
                    
                    
                }
            }
            .onAppear{
                
                withAnimation(.spring()) {
                    showblacknav = false
                    
                 
                    
                }
            }
            .onDisappear{
                
                withAnimation(.spring()) {
//                    showblacknav = false
                }
            }
        
        
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            
            if offset > 60 {
                //hide profile after pulling down cover
                withAnimation(.spring()) {
                    showProfile = false
                    hidemainTab = false
                }
            }
            
            if offset < -110 {
                
                withAnimation(.spring()) {
                    showblacknav = true
                    
                }
                if offset < previousOffset {
                    // Scrolling up
                    withAnimation(.spring()) {
                        hidemainTab = true
                    }
                } else {
                    // Scrolling down
                    withAnimation(.spring()) {
                        hidemainTab = false
                    }
                }
                
            }
            
            else {
                withAnimation(.spring()) {
                    showblacknav = false
                
                    
                }
                
                
            }
            
          
            
            previousOffset = offset
        }
    }
    
   
    
    func typeWriter(_ text: String, completion: @escaping () -> Void) {
      
        //typeText = ""
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        typeText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                // Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                //   withAnimation(.easeInOut) {
                //  typeText = original
                //
                //   }
                // }
                
            }
        }
    }
    

   
}
