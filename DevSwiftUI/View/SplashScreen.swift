//
//  SplashScreen.swift
//  DevSwiftUI
//
//  Created by PM Student on 12/8/22.
//

import SwiftUI
import Firebase

struct SplashScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    
    var body: some View {
        if userIsLoggedIn {
            ContentView()
        } else {
            content
        }
    }

    var content: some View {
        VStack {
            Text("Welcome")
                .foregroundColor(.black)
                .font(.system(size: 40, weight: .bold, design: .rounded))
            
            TextField("Email", text: $email)
                .foregroundColor(.black)
                .textFieldStyle(.plain)
                .padding(.leading)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading)
                }
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundColor(.black)
            
            SecureField("Password", text: $password)
                .padding(.leading)
                .foregroundColor(.black)
                .textFieldStyle(.plain)
                .placeholder(when: password.isEmpty) {
                    Text("Password")
                        .padding(.leading)
                        .foregroundColor(.black)
                        .bold()
                }
            
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundColor(.black)
            
            Button {
                register()
            } label: {
                
                Text("Sign Up")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                
            }
            .padding(.top)
            .offset(y: 100)
            
            
            Button {
                login()
            } label: {
                Text("Already have an account? Login")
                    .bold()
                    .foregroundColor(.black)
            }
            .padding(.top)
            .offset(y: 110)
            
            
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
