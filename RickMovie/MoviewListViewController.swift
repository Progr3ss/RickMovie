//
//  ViewController.swift
//  RickMovie
//
//  Created by Martin Chibwe on 4/30/21.
//

import UIKit
/**
 Create an iOS app to show the list of Episodes from the show Rick and Morty.
 API Doc: https://rickandmortyapi.com/documentation/#episode
 Application Requirements:
 • Fetch one page of episodes at a time
 • Show a list of episodes
 • When user scrolls to the end of content, fetch the next page of episodes (if available)
 • Tapping on a show should take the user to a new screen showing episode details
 Development Requirements:
 • Use the design pattern of you choice (MVC, MVVM, VIPER, etc)
 • UI can be designed in your preferred way (SwiftUI, Storyboard, Programmatically)
 • The code must be shared on GitHub or BitBucket
 • Commits should always have clear descriptions of work done
 • Any 3rd party frameworks/assets used must be licensed for public use
 Plus Points:
 • Make it pretty
 • Comment code where needed
 • Add unit tests
 • Add character list to detail screen and make those take the user to character details
 • Cache data for offline use
 
 
 */
@objc class MoviewListViewController: UIViewController {
    var movieList = [results]()
    
//    override func viewDidLayoutSubviews() {
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMovies()
        
    }


    func getMovies() {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: urlString) else {
            print("url \(urlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response,error in
            guard let data = data, error == nil else {
                print("bad error task")
                return
            }
            print("data ", data)
            var results : MovieModelResults?
            do {
                let results = try JSONDecoder().decode(MovieModelResults.self, from: data)
                
                self.movieList = results.results
                print("json results \(results.results) ")
            }catch {
               print("failed to decode with error: \(error)")
            }
            
        })
        task.resume()
    }
}
extension MoviewListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieListTableViewCell
        
        cell.configure(for: self.movieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
}

