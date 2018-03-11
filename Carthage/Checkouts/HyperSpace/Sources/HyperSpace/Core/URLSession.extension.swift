//
//  URLSession.extension.swift
//  HyperSpace
//
//  Created by Cavelle Benjamin on 18-Jan-02 (01).
//

import Foundation

#if os(Linux)
  import Glibc
  import Dispatch
#endif


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
