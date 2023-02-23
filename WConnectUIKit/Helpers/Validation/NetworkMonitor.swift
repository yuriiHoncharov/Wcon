//
//  NetworkMonitor.swift
//  WConnect
//
//  Created by Yurii Honcharov on 25.05.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    private(set) var isConnected = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor.queue")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
