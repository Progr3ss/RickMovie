//
//  MovieTableViewController.swift
//  RickMovie
//
//  Created by Martin Chibwe on 4/30/21.
//

import UIKit

class MovieTableViewController: UITableViewController {
    @IBOutlet var movieTableView: UITableView!
    var movieList = [results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("CellCount \(movieList.count)")
        return movieList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieListTableViewCell
        cell.configure(for: self.movieList[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEpisodes" {
            if let nextVC = segue.description as? EpisodesTableViewController {
                nextVC.movieEpisodes = movieList
            }
        }
    }


}
//MARK: Helper Functions
extension MovieTableViewController {
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
                let movieJsonResults = try JSONDecoder().decode(MovieModelResults.self, from: data)
                self.movieList = movieJsonResults.results
                DispatchQueue.main.async {
//                  self.isLoading = false
                  self.movieTableView.reloadData()
                }
                
                print("json results \(movieJsonResults.results) ")
            }catch {
               print("failed to decode with error: \(error)")
            }
            
        })
        task.resume()
    }
}
