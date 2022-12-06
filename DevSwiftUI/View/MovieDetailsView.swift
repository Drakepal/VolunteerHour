//
//  MovieDetailsView.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
    
    var movie: Movie
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                Text(movie.title)
                Text(movie.description)
            }
            Section(header: Text("Time")) {
                HStack {
                    if movie.year == "1" {
                        Text(movie.year)
                        Text("Hour")
                    } else {
                        Text(movie.year)
                        Text("Hours")
                    }
                }
                HStack {
                    if movie.minutes >= "2" {
                        Text(movie.minutes)
                        Text("Minutes")
                    } else {
                        Text(movie.minutes)
                        Text("Minute")
                    }
                }
            }
        }
        .navigationBarTitle(movie.title)
        .navigationBarItems(trailing: editButton {
            self.presentEditMovieSheet.toggle()
        })
        .onAppear() {
            print("MovieDetailsView.onAppear() for \(self.movie.title)")
        }
        .onDisappear() {
            print("MovieDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditMovieSheet) {
            MovieEditView(viewModel: MovieViewModel(movie: movie), mode: .edit)
        }
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let movie = Movie(title: "title movie", description: "this is a sample description", year: "2022")
//        return
//        NavigationView {
//            MovieDetailsView(movie: movie)
//        }
//    }
//}
