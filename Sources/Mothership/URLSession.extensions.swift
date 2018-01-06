//
//  URLSession.extensions.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

extension URLSession {
  
  func sendSynchronousRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = self.dataTask(with: request) { (data, response, error) in
      
      completionHandler(data,response,error)
      
      semaphore.signal()
      
    }
    
    task.resume()
    
    _ = semaphore.wait(timeout: .distantFuture)
    
  }
  
  
  func sendAsynchronousRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    
    let task = self.dataTask(with: request) { data, response, error in
      
      completionHandler(data, response, error)
      
    }
    
    task.resume()
    
    return task
    
  }
  
}
