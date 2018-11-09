//
//  QuickPaySDK.swift
//  QuickPayExample
//
//  Created by Steffen Lund Andersen on 06/11/2018.
//  Copyright © 2018 QuickPay. All rights reserved.
//

import Foundation


public class QuickPaySDK {
    
    public class func testStuff() {
        // Create the needed headers
        let headers = QPDefaultHeader(authorization: "e42538f4ca60b415f13d147aa3158d09c25c8f4f4111c5c0b8356518c2fb03a7")

        // The orderId and currency parameters are required.
        // NOTE!! Order Id's can only be used once. You need to change it to run the example again.
        let params = QPCreatePaymentParameters()
        params.orderId = "164535"
        params.currency = "DKK"
        params.textOnStatement = "QuickPay SDK on iOS"
        
        params.invoiceAddress = QPAddress()
        params.invoiceAddress?.name = "CV"
        params.invoiceAddress?.city = "Aarhus"
        params.invoiceAddress?.countryCode = "DNK"
        
        let createPaymentRequest = QPCreatePaymentRequest(headers: headers, parameters: params)
        createPaymentRequest.sendRequestWithCompletionHandler { (data, response, error) in
            // print("Got response from POST /payments/ \n \(response) with error \(error).")

            if let httpResponse = response as? HTTPURLResponse {
                if(HTTPStatusCode(rawValue: httpResponse.statusCode) == .badRequest) {
                    print("BAD REQUEST")
                    // TODO: We need to handle this.
                    return
                }
            }
            
            if let data = data {
                let root = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>

                if let root = root {
                    let paymentId = root!["id"] ?? ""
                    print("PaymentId: \(paymentId)")
                }

            }
        }
    }
}
