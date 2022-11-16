//
//  MovieViewModel.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import FirebaseFirestore
import Foundation
import Combine


class MovieViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var modified = false
    
    private var cancellabels = Set<AnyCancellable>()
    
    init(movie: Movie = Movie(title: "", description: "", year: "")) {
        self.movie = movie
        
        self.$movie
            .dropFirst()
            .sink { [weak self] movie in
                self?.modified = true
            }
            .store(in: &self.cancellabels)
    }
    
    private var db = Firestore.firestore()
    
    private func addMovie(_ movie: Movie) {
        do {
            let _ = try db.collection("movielist").addDocument(from: movie)
        }
        catch {
            print(error)
        }
    }
    
    private func updateMovie(_ movie: Movie) {
        if let documentId = movie.id {
            do {
                try db.collection("movielist").document(documentId).setData(from: movie)
            }
            catch {
                print(error)
            }
        }
    }
    private func updateOrAddMovie() {
        if let _ = movie.id {
            
        } else {
            addMovie(movie)
        }
    }
    
    private func removeMovie() {
        if let documentId = movie.id {
            db.collection("movielist").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func handleDoneTapped() {
        self.updateOrAddMovie()
    }
    func handleDeleteTapped() {
        self.removeMovie()
    }
    
    
    
}
