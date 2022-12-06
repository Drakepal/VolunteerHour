//
//  Movie.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Movie: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var year: String
    var minutes: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case year
        case minutes
    }
}
