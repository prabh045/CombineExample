//
//  ViewModel.swift
//  CombineExample
//
//  Created by Prabhdeep Singh on 19/01/21.
//  Copyright © 2021 Phoenix. All rights reserved.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var time = ""
    @Published var users = [User]()
    //to keep subscription alive
    private var anyCancellable = Set<AnyCancellable>()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    init() {
        setupPublishers()
    }
    
    func setupPublishers() {
        setupTimerPublisher()
        setupDataTaskPublisher()
    }
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                }
                return data
        }
        .decode(type: [User].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (_) in
        }) { (users) in
            self.users = users
        }
        .store(in: &anyCancellable)
        
    }
    
    private func setupTimerPublisher() {
        Timer.publish(every: 1, on: .main, in: .default)
            //So that timer publisher starts publishing
            .autoconnect()
            //so that ui updates on main thread
            .receive(on: RunLoop.main)
            .sink { (date) in
                self.time = self.formatter.string(from: date)
        }
        .store(in: &anyCancellable)
    }
}
