//
// SWApp
//
// CancellableOperation
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

class CancellableOperation {
    private let queue: OperationQueue
    private let completionQueue: OperationQueue
    private let blocks: [BlockOperation]
    private let completion: (() -> Void)?
    private(set) var isExecuting: Bool = false
    
    init(operations: [BlockOperation],
         qualityOfService: QualityOfService = .userInitiated,
         completion: @escaping () -> Void,
         completionQueue: OperationQueue = .main) {
        self.queue = OperationQueue()
        self.queue.qualityOfService = qualityOfService
        self.blocks = operations
        self.completion = completion
        self.completionQueue = completionQueue
    }
    
    func start() {
        isExecuting = true
        queue.addOperations(blocks, waitUntilFinished: false)
        queue.addBarrierBlock { [weak self] in
            self?.completionQueue.addOperation {
                self?.completion?()
                self?.isExecuting = false
            }
        }
    }
    
    func cancel() {
        queue.cancelAllOperations()
        isExecuting = false
    }
}
