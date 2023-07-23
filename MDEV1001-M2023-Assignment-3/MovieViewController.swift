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
    

    
   // var movies = [Array<Any>]()
    var index = Int()
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
//        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//                noDataLabel.text          = "Oops!No data available.\nSearch for movies to retrieve the data."
//        noDataLabel.numberOfLines = 0
//                noDataLabel.textColor     = UIColor.black
//                noDataLabel.textAlignment = .center
//        self.tableView.backgroundView  = noDataLabel
//
       /* fetchMovies { [weak self] movies, error in
            DispatchQueue.main.async
            {
                if let movies = movies
                {
                    if movies.isEmpty
                    {
                        // Display a message for no data
                        self?.displayErrorMessage("No movies available.")
                    } else {
                        self?.movies = movies
                        self?.tableView.reloadData()
                    }
                } else if let error = error {
                    if let urlError = error as? URLError, urlError.code == .timedOut
                    {
                        // Handle timeout error
                        self?.displayErrorMessage("Request timed out.")
                    } else {
                        // Handle other errors
                        print("err",error.localizedDescription.codingKey)
                        self?.displayErrorMessage(error.localizedDescription)
                    }
                }
            }
        }*/
    }
    /*
    func displayErrorMessage(_ message: String)
    {
        print("msg",message)
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void)
    {
        print("urlll","https://www.omdbapi.com/?apikey=\(apiKey)&t=Mission+Impossible")
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&t=Mission+Impossible") else
        {
            completion(nil, nil) // Handle URL error
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error) // Handle network error
                return
            }

            print("data",data)
            guard let data = data else {
                completion(nil, nil) // Handle empty response
                return
            }

            do {
                print("dhgghggg",data)
                let objMov =
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(movies, nil) // Success
            } catch {
                completion(nil, error) // Handle JSON decoding error
            }
        }.resume()
    }
*/
    
    func fetchMovieDataFromAPI(_ searchText : String) {
        
        
            // Replace apiURL with the actual URL of the API endpoint
        let newsearchText = searchText.replacingOccurrences(of: " ", with: "+")
            print("urlll","https://www.omdbapi.com/?apikey=\(apiKey)&t=\(newsearchText)")
        
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
                   // self.checkforTV()
                    // Now you have the movie object, you can use it as needed
                    print(movie.Title)
                    print(movie.Genre)
                    DispatchQueue.main.async
                    {
                        self.searchBar.text = ""
                        self.tableView.reloadData()
                    }
                    // ... and so on
                    
                    
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()
        
        
}

 func checkforTV()
    {
        if self.arr_movies.count > 0
        {
            //tableView.reloadData()
        }
        
    }


    
    @IBAction func searchButton(_ sender: Any) {
        self.view.endEditing(true)

        if self.searchBar.text != ""
        {
//            check = "yes"
//            self.tableView.backgroundView = nil
            fetchMovieDataFromAPI(self.searchBar.text!)
            
            
            
        }
        else{
            let alertController = UIAlertController(title: "Alert", message: "Please enter movie name for retrieving the list of movies.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("cc",self.arr_movies.count)
        if self.arr_movies.count > 0{
            print("c2",self.arr_movies.count)
            return self.arr_movies.count
        }else{
            print("c3",self.arr_movies.count)
            return 0
        }
        
        
//        if self.check != "no"{
//            print("count",arr_movies.count)
//            return arr_movies.count
//
//
//        }
//        else{
//                return 0
//            }
      
        
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
        
 



        //            let imgData = movie.thumbnail != nil ? UIImage(data: movie.thumbnail!) : nil
        //            cell.thumbnailImage?.image = imgData ?? selectedPosterImage
        return cell
        
        
    }
    
    
    // Tap on particular cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MovieDetailSegue", sender: indexPath)
    }
   
   
    
   
}
