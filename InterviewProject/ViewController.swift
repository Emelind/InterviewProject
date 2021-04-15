//
//  ViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-14.
//

import UIKit

//  api avail at https://dog.ceo/api/breeds/image/random/50
//The basic feature set of the app is: 
//- Get list of dog photos from the JSON API  - Show a gallery view of all dog photos 
//- Show a detail view for a single dog photo - Make the app as user-friendly as you can.

struct DemoData: Codable {
    let message: [String]
}


class ViewController: UIViewController {
    
    private let myView: UIView = {
       let myView = UIView()
        myView.backgroundColor = .link
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private let secondView: UIView = {
        let secondView = UIView()
         secondView.backgroundColor = .systemTeal
         secondView.translatesAutoresizingMaskIntoConstraints = false
         return secondView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let localData = self.readLocalFile(forName: "data") {
            self.parse(jsonData: localData)
        }
        
        let urlString = "https://dog.ceo/api/breeds/image/random/50"
        self.loadJson(fromURLString: urlString) { (result) in
            switch (result) {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
        
        view.backgroundColor = .white
        view.addSubview(myView)
        myView.addSubview(secondView)
        addContraints()
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DemoData.self, from: jsonData)
            
            print("URL: ", decodedData.message)
            print("===================================")
        } catch {
            print("decode error")
        }
    }
    
    
    // constraint function
    private func addContraints() {
        var constraints = [NSLayoutConstraint]()
        
        //Add
        constraints.append(myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        // Second view
        constraints.append(secondView.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 0.5))
        constraints.append(secondView.heightAnchor.constraint(equalTo: myView.heightAnchor, multiplier: 0.5))
        constraints.append(secondView.centerYAnchor.constraint(equalTo: myView.centerYAnchor))
        constraints.append(secondView.centerXAnchor.constraint(equalTo: myView.centerXAnchor))
        
        //Activate (applying)
        NSLayoutConstraint.activate(constraints)
    }
}

