//
//  ContentView.swift
//  BTS-Booking Cafe
//
//  Created by User11 on 2022/10/26.
//
import SwiftUI
import AVFoundation

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let food = ["ayam" , "ago", "nasi", "soto betawi", "rendang" , "mie ayam", "telur asin"]
    let drink = ["esteh" , "jusjeruk", "juspukat", "jusmelon", "esbuah" , "kolak"]

    var body: some View {
        ZStack (alignment: .bottom)
        {
            Image("bts-appwall")
            .resizable()
            .ignoresSafeArea()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

          ScrollView{
          HStack{
            Button("<<Back to HomePage")
            { presentationMode.wrappedValue.dismiss() }
                .background(Color.purple)
                .foregroundColor(.white)
                .hoverEffect(.lift)
                .clipShape(Capsule())

              Spacer()
            }
            Spacer().frame(height :50)
            
            VStack
            {
                Image("menu")
                .resizable()
                .scaledToFill()
                
                Spacer().frame(height :30)
                
                VStack
                {
                    Text("Food")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    
                    ScrollView(.horizontal) {
                            let rows = [GridItem()]
                                LazyHGrid(rows: rows) {
                                ForEach(food.indices, id: \.self) { item in
                                    foodView(food: food[item], number: item + 1)
                                          }
                                      }.padding()
                              }.fixedSize(horizontal: false, vertical: true)
                }
                
                VStack
                {
                    Text("Drink")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                
                    ScrollView(.horizontal) {
                            let rows = [GridItem()]
                                LazyHGrid(rows: rows) {
                                ForEach(drink.indices, id: \.self) { item in
                                    drinkView(drink: drink[item], number: item + 1)
                                          }
                                      }.padding()
                              }.fixedSize(horizontal: false, vertical: true)
        }
       }
     }
   }
}
}


struct drinkView: View {
    let drink: String
   let number: Int
    var body: some View {
        VStack {
            Image(drink)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipped()
           }
}
}

struct foodView: View {
    let food: String
   let number: Int
    var body: some View {
        VStack {
            Image(food)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipped()
           }
}
}

struct ContentView: View {
    var place = ["Keelung", "Taipei", "New Taipei", "Taoyuan", "Taichung"]
    var Seat = ["Near Enterance", "Near Toilet" , "Near Window"]
    
    @State private var bts = false
    
    @State private var isPresented = false
    
    @State private var selectedPlace = "Taipei"
    @State private var selectedSeat = "Near Toilet"
    
    @State private var member = false
    @State private var done = false
    
    @State private var date = Date()
    @State private var time = Date()
    
    @State private var person: CGFloat = 1
    @State private var kid = 1
    
    @State private var name = ""
    @State private var membernum = ""
    @State private var number = ""
    @State private var email = ""

    @State private var isPlay = false

  let player = AVPlayer(url: Bundle.main.url(forResource: "runbts", withExtension: "mp3")!)

    var body: some View {
        VStack{
            Form{
                VStack{
                    Text("!BTS Welcome You!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    Image("bts-welc")
                        .resizable()
                        .scaledToFill()
                    
                    Spacer().frame(height :20)
                    
                    Text("Borahae, ARMY!")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    }

                    Toggle("Play Music", isOn: $isPlay)
                      .onChange(of: isPlay,
                                perform: { value in
                                      if value {
                                            player.play()
                                      } else {
                                            player.pause()
                                          }
                      })
              

                    Button("Show Menu!"){
                               isPresented.toggle()
                           }
                          .foregroundColor(.purple)
                           .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
                    
                    DisclosureGroup("BTS Member", isExpanded: $bts) {
                    Text("RM , Jin , Suga, JHope, V, Jimin, JK")
                        .foregroundColor(.purple)
                        }
                
                Group{
                                    
                    HStack{
                        Text("Full Name            :")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        TextField("your name", text: $name)
                    }
                    
                    HStack{
                        Text("Mobile Number :")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        TextField("number", text: $number)
                    }
                    
                    HStack{
                        Text("E-Mail Address :")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        TextField("email address", text: $email)
                    }
                    
                    Toggle(isOn: $member, label: {
                        Text("Membership")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                    })
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    if(member) {
                        HStack{
                            Text("Member :")
                                .foregroundColor(.purple)
                                .fontWeight(.bold)
                            TextField("number", text: $membernum)
                              .keyboardType(.decimalPad)
                        }
                    }
                    
                    Text("\nBooking Request")
                        .foregroundColor(.purple)
                        .fontWeight(.bold)
                    
                    VStack{
                    HStack {
                        Text("Person : \(Int(person))")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        Slider(value: $person, in: 1...10, step: 1)
                        
                    }
                        HStack{
                        Text("Toddler : \(Int(kid))")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                            Stepper("", value: $kid, in: 0...5)
                    }
                }
                
                Group{
                    Text("Place")
                        .foregroundColor(.purple)
                        .fontWeight(.bold)
                    Picker(selection: $selectedPlace, label: Text("")) {
                        ForEach(place, id: \.self) { (role) in
                            Text(role)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                    Text("Seat")
                        .foregroundColor(.purple)
                        .fontWeight(.bold)
                    Picker(selection: $selectedSeat, label: Text("")) {
                        ForEach(Seat, id: \.self) { (role) in
                            Text(role)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Group{
                    DatePicker(selection: $date, displayedComponents: .date)
                    {
                        Text("Date")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        
                    }
                    .padding(.horizontal)
                    .accentColor(.purple)
                    
                    
                    DatePicker(selection: $time, displayedComponents: .hourAndMinute)
                    {
                        Text("Time")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        
                    }
                    .accentColor(.purple)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(.horizontal)
                }
            }
            
            Button(action: {
                 self.done = true
            }) {
                 Text("ORDER")
                    .foregroundColor(.purple)
                    .fontWeight(.bold)
                    .frame(width: 300, alignment: .center)
                }
                 .actionSheet(isPresented: $done) {
                    ActionSheet(title: Text("WELCOME HOME, ARMY!"),
                    message: Text("The reservation for " + name + " has been sent to: " + email),
                    buttons: [.default(Text("OK"))])
                  }.buttonStyle(PlainButtonStyle())
        }
   }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}
