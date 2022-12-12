//
//  ContentView.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    
    @EnvironmentObject var authModel: AppViewModel
    
    @State var isLinkActive = false
    
    @StateObject var viewModel = MoviesViewModel()
    @State var presentAddMovieSheet = false

    
    
    private var addButton: some View {
        Button(action: { self.presentAddMovieSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private var signOutButton: some View {
        
//      NavigationLink(destination: SplashScreen(), isActive: $isLinkActive ){
//            Button(action: {
//                authModel.signOut()
//                self.isLinkActive = true
//            }, label: {
//                Text("Sign Out")
//            })
//        }
        Button(action: {
            authModel.signOut()
        }, label: {
            Text("Sign Out")
        })
    }
    
    private func movieRowView(movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                //Text(movie.description)
                //.font(.subheadline)
                if movie.year == "1" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year == "" && movie.minutes == "1" {
                    HStack {
                        Text(movie.minutes)
                        Text("minute")
                    }
                    
                } else if movie.year == "0" && movie.minutes == "1" {
                    HStack {
                        Text(movie.minutes)
                        Text("minute")
                    }
                } else if movie.year == "0" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year == "" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year >= "2" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.year)
                            .font(.subheadline)
                        Text("hours")
                        Text(movie.minutes)
                        Text("minutes")
                    }
                    
                
                }  else if movie.year >= "2" && movie.minutes == "" {
                    HStack {
                        Text(movie.year)
                        Text("hours")
                    }
                } else if movie.year >= "2" && movie.minutes == "0" {
                    HStack {
                        Text(movie.year)
                        Text("hours")
                    }
                } else if movie.year == "1" && movie.minutes == "1" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                        Text(movie.minutes)
                        Text("minute")
                    }
                } else if movie.year == "1" && movie.minutes == "" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                    }
                } else if movie.year == "1" && movie.minutes == "0" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                    }
                } else if movie.year >= "2" && movie.minutes == "1" {
                    HStack {
                        Text(movie.year)
                        Text("hours")
                        Text(movie.minutes)
                        Text("minute")
                    }
                } else if movie.year >= "2" && movie.minutes == "12" {
                    HStack {
                        Text(movie.year)
                        Text("hours")
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year == "1" && movie.minutes == "12" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year == "" && movie.minutes == "12" {
                    HStack {
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year == "0" && movie.minutes == "12" {
                    HStack {
                        Text(movie.minutes)
                        Text("minutes")
                    }
                }
                     
                
                
//                    HStack {
//                        Text(movie.year)
//                            .font(.subheadline)
//                        if movie.year >= "2" {
//                            Text("Hours")
//                        } else {
//                            Text("Hour")
//                        }
//                    }
                }
            }
        }
    

    var body: some View {
        
            
            NavigationView {
                
                List {
                    
                    ForEach(viewModel.movies) { movie in
                        movieRowView(movie: movie)
                    }
                }
                
                .navigationBarTitle("Volunteer List")
                
                .navigationBarItems(leading: signOutButton, trailing: addButton)
                .onAppear() {
                    print("MoviesListView appears. Subscribing to data updates.")
                    self.viewModel.subscribe()
                }
                .sheet(isPresented: self.$presentAddMovieSheet) {
                    MovieEditView()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
