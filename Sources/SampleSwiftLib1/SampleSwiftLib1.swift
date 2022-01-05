import Foundation
import XCTest
public class SampleSwiftLib1:XCTestCase {
    public private(set) var text = "Hello, World!"
    /*public init() {
       // testCallRequest()
    }*/
    public func testCallRequest() {
        print("------------****!!!!----test call request------****!!!!------------")
        guard let url = URL(string: "https://node-clarity-testnet.make.services/rpc") else {
            print("Can not initiate url")
            return
        }
        let json2: [String: Any] = ["id": 1, "method": "chain_get_state_root_hash","jsonrpc":"2.0","params":"[]"] as [String:Any]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: json2, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
       /* DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            print("------------------------------")
            self.testCall2()
            print("------------------------------")
        })*/
        // create post request
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            expectation.fulfill()

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                //self.testCall()
            } else {
                print("Error get data")
            }
        }
        task.resume()
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
