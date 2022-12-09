//
//  SplashScreen.swift
//  DevSwiftUI
//
//  Created by PM Student on 12/8/22.
//

import SwiftUI
import FirebaseAuth


class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //success
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        NSLog("herez")
        
        
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //success
                self?.signedIn = true
            }
        }
        
    }
}


struct SplashScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                ContentView()
            } else {
                SignInView()
            }
            
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        
            VStack {
                Spacer()
                Text("Sign In")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                   Spacer()
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    })
                    
                    NavigationLink("Create Account", destination: SignUpView())
                        .padding()
                }
                .padding()
                
                Spacer()
            }
            
        
    }
}
struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        
            VStack {
                Spacer()
                Text("Sign Up")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                   Spacer()
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    })
                    .padding()
                }
                .padding()
                
                Spacer()
            }
    }
}
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}



