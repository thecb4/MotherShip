//
//  TestFlight.service.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

class TestFlightService {
  
  let session: URLSession
  
//  struct TesterPost: Codable {
//    let email: String
//    let firstName: String
//    let lastName: String
//  }
  
  init() {
    
    self.session = URLSession.shared
    
  }
  
  func groups(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Group] {
    
//    var text = ""
    
    var info = Groups()
    
    let request = URLRequest(
      url: URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/groups")!,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 500
    )
    
    let _ = session.sendSynchronousRequest(with:request) {
      (data, response, error) -> Void in
      
      if (error != nil) {
        print(error!)
      } else {
        let httpResponse = response as! HTTPURLResponse
        print(httpResponse)
        
        guard let data = data else { return }
        
        guard let _text = String(data: data, encoding: String.Encoding.utf8) else { return }
        
        print(_text)
        
//        text = _text
        
        do {
          
          let decoder = JSONDecoder()
          
          info = try decoder.decode(Groups.self, from: data)
          
          print(info.data)
          
        } catch {
          print(error)
        }
      }
    }
    
    return info.data
    
  }
  
  
  func testers(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Tester] {
    
    let pageSize = 40
    
    var info = Testers()
    
    let request = URLRequest(
      url: URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/testers?limit=\(pageSize)&sort=email&order=asc")!,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 500
    )
    
    let _ = session.sendSynchronousRequest(with:request) {
      (data, response, error) -> Void in
      
      if (error != nil) {
        print(error!)
      } else {
        let httpResponse = response as! HTTPURLResponse
        print(httpResponse)
        
        guard let data = data else { return }
        
        guard let text = String(data: data, encoding: String.Encoding.utf8) else { return }
        
        print(text)
        
        do {
          
          let decoder = JSONDecoder()

          info = try decoder.decode(Testers.self, from: data)
          
          print(info.data)
          
        } catch {
          print(error)
        }
        
      }
    }
    return info.data
  }
  
//  func add(tester: Tester, to )
  
  func add(tester: Tester, appID: AppIdentifier, teamID: TeamIdentifier, with authKey: String) -> String {
    
    var request = URLRequest(
      url: URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/testers")!,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 500
    )
    
    var text = ""
    
    let payload = Tester(email:tester.email, firstName:tester.firstName, lastName:tester.lastName)
    
    request.http_method = .post
    
    let jsonLoginData = try? JSONEncoder().encode(payload)
    request.httpBody = jsonLoginData
    print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
   
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
    request.setValue(authKey, forHTTPHeaderField: "X-Apple-Widget-Key")
    request.setValue("application/json, text/javascript", forHTTPHeaderField: "Accept")
    
    let _ = session.sendSynchronousRequest(with:request) {
      (data, response, error) -> Void in
      
      if (error != nil) {
        print(error!)
      } else {
        let httpResponse = response as! HTTPURLResponse
        print(httpResponse)
        
        guard let data = data else { return }
        
        guard let _text = String(data: data, encoding: String.Encoding.utf8) else { return }
        
        print(_text)
        
        text = _text
        
//        do {
//
//          //          let decoder = JSONDecoder()
//          //
//          //          info = try decoder.decode(Testers.self, from: data)
//          //
//          //          print(info.data)
//
//        } catch {
//          print(error)
//        }
      }
    }
    
    return text
    
  }
  
  func add(to groupID:String, tester: Tester,appID: AppIdentifier, teamID: TeamIdentifier, with authKey: String) -> String {
    
    // providers/#{team_id}/apps/#{app_id}/groups/#{group_id}/testers
    

    
    var request = URLRequest(
      url: URL(string: "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/groups/\(groupID)/testers")!,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 500
    )
    
    var text = ""
    
    let payload = [Tester(email:tester.email, firstName:tester.firstName, lastName:tester.lastName)]
    
    request.http_method = .post
    
    let jsonLoginData = try? JSONEncoder().encode(payload)
    request.httpBody = jsonLoginData
    print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
//    request.setValue(authKey, forHTTPHeaderField: "X-Apple-Widget-Key")
//    request.setValue("application/json, text/javascript", forHTTPHeaderField: "Accept")
    
    let _ = session.sendSynchronousRequest(with:request) {
      (data, response, error) -> Void in
      
      if (error != nil) {
        print(error!)
      } else {
        let httpResponse = response as! HTTPURLResponse
        print(httpResponse)
        
        guard let data = data else { return }
        
        guard let _text = String(data: data, encoding: String.Encoding.utf8) else { return }
        
        print(_text)
        
        text = _text
        
//        do {
//
//          //          let decoder = JSONDecoder()
//          //
//          //          info = try decoder.decode(Testers.self, from: data)
//          //
//          //          print(info.data)
//
//        } catch {
//          print(error)
//        }
      }
    }
    
    return text
    
  }
  
//  public func invite(testerID: String, to appID: AppIdentifier, with authKey: String) -> String {
//    
//    var text:String = ""
//    
//    var request = URLRequest(
//      url: URL(string: "https://itunesconnect.apple.com/testflight/v1/invites/\(appID)/resend?testerId=\(testerID)")!,
//      cachePolicy: .useProtocolCachePolicy,
//      timeoutInterval: 500
//    )
//    
//    request.http_method = .post
//    
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
//    request.setValue(authKey, forHTTPHeaderField: "X-Apple-Widget-Key")
//    request.setValue("application/json, text/javascript", forHTTPHeaderField: "Accept")
//    
//    let _ = session.sendSynchronousRequest(with:request) {
//      (data, response, error) -> Void in
//      
//      if (error != nil) {
//        print(error!)
//      } else {
//        let httpResponse = response as! HTTPURLResponse
//        print(httpResponse)
//        
//        guard let data = data else { return }
//        
//        guard let _text = String(data: data, encoding: String.Encoding.utf8) else { return }
//        
//        print(_text)
//        
//        text = _text
//        
////        do {
////
//////          let decoder = JSONDecoder()
//////
//////          info = try decoder.decode(Testers.self, from: data)
//////
//////          print(info.data)
////
////        } catch {
////          print(error)
////        }
//      }
//    }
//    
//    return text
//  }
}
