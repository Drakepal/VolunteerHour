//
//  ContentView.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MoviesViewModel()
    @State var presentAddMovieSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddMovieSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func movieRowView(movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                //Text(movie.description)
                //.font(.subheadline)
                if movie.year == "" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.minutes)
                        Text("Minutes")
                    }
                } else if movie.year == "1" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.year)
                        Text("hour")
                        Text(movie.minutes)
                        Text("minutes")
                    }
                } else if movie.year >= "2" && movie.minutes >= "2" {
                    HStack {
                        Text(movie.year)
                            .font(.subheadline)
                        if movie.year >= "2" {
                            Text("Hours")
                        }
                        Text(movie.minutes)
                        if movie.minutes >= "2" {
                            Text("Minutes")
                        }
                    }
                
                
                } else if movie.year == "" && movie.minutes == "1" {
                    HStack {
                        Text(movie.minutes)
                        Text("minute")
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
            .navigationBarItems(trailing: addButton)
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
