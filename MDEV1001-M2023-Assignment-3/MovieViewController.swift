//
//  MovieViewController.swift
//  MDEV1001-M2023-Assignment-3
//
//  Created by Jaivleen Kour on 2023-07-22.
//

import UIKit
import Foundation

class MovieViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedPosterImage: UIImage?
    var check = "no"
    var apiKey = ""
    var searchMovieText = ""
    var arr_movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //get api key from omdb api
        apiKey = "80597972"
        
        //self.searchBar.delegate = self
        
    
    }
 
    
    func fetchMovieDataFromAPI(_ searchText : String) {
        
        // Replace apiURL with the actual URL of the API endpoint
           let newsearchText = searchText.replacingOccurrences(of: " ", with: "+")
           guard let apiURL = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&t=\(newsearchText)") else {
           print("Invalid API URL")
           return
            }
            
            URLSession.shared.dataTask(with: apiURL) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                  
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(Movie.self, from: data)
                    self.arr_movies.append(movie)
                    print("mmmm",self.arr_movies.count)
                    // Now you have the movie object, you can use it as needed
                    print(movie.Title)
                    print(movie.Genre)
                    DispatchQueue.main.async
                    {
                        self.searchBar.text = ""
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()
        
}


    @IBAction func searchButton(_ sender: Any) {
        self.view.endEditing(true)
        if self.searchBar.text != ""
        {
            check = "yes"
            self.tableView.backgroundView = nil
            fetchMovieDataFromAPI(self.searchBar.text!)
            
        }
        else{
            let alertController = UIAlertController(title: "Alert", message: "Please enter movie name for retrieving the list of movies.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arr_movies.count > 0{
            return self.arr_movies.count
        }else{
            print("c3",self.arr_movies.count)
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                    noDataLabel.text          = "Oops!No data available.\nSearch for movies to retrieve the data."
            noDataLabel.numberOfLines = 0
                    noDataLabel.textColor     = UIColor.black
                    noDataLabel.textAlignment = .center
            self.tableView.backgroundView  = noDataLabel
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        let movie = arr_movies[indexPath.row]
        cell.titleLabel?.text = movie.Title
        cell.studioLabel?.text = "Studio: \(movie.Production)"
        cell.ratingLabel?.text = "\(movie.imdbRating)"
        cell.yearLabel?.text = "Date of Release: \(movie.Year)"
        
        
        let url = URL(string: movie.Poster)!
        // Fetch Image Data
        DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        cell.thumbnailImage.image = UIImage(data: data)
                    }
                }
            }
        return cell
        
    }
    
    
    // Tap on particular cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MovieDetailSegue", sender: indexPath)
    }
   
    // Swipe Left Gesture
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        {
            if editingStyle == .delete
            {
                let movie = arr_movies[indexPath.row]
                ShowDeleteConfirmationAlert(for: movie) { confirmed in
                    if confirmed
                    {
                        self.deleteMovie(at: indexPath)
                    }
                }
            }
        }
        
        func ShowDeleteConfirmationAlert(for movie: Movie, completion: @escaping (Bool) -> Void)
        {
            let alert = UIAlertController(title: "Delete Movie", message: "Are you sure you want to delete this movie?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(false)
            })
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                completion(true)
            })
            
            present(alert, animated: true, completion: nil)
        }
        
        func deleteMovie(at indexPath: IndexPath)
        {
            let movie = arr_movies[indexPath.row]
            self.arr_movies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    
}
