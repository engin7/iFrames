# iFrames
TMDb App 

## About

iFrames is an iOS app which connects to The Movie Database (TMDb) API and show users list of movies. 
Top 100 movies are shown when user launch of the app. This data is persisted by Realm Data Base. 
User can search for other movies in the DataBase and by clicking see the details of the movie. 
Network framework used in the screen to update the UI when internet connection is lost and then recieved again.	
MVC design pattern and RxSwift Framework used during development of the application.    
	 
<img width="214" alt="search for movies" src="https://user-images.githubusercontent.com/32449276/89505800-da12f180-d7d2-11ea-9901-14707381383e.png"> <img width="214" alt="movie details" src="https://user-images.githubusercontent.com/32449276/89505809-de3f0f00-d7d2-11ea-9c06-4e17d808b83f.png"> <img width="214" alt="scroll overview text" src="https://user-images.githubusercontent.com/32449276/89505818-e0a16900-d7d2-11ea-921d-25be3296e5e2.png"> <img width="214" alt="fan art" src="https://user-images.githubusercontent.com/32449276/89506606-0d09b500-d7d4-11ea-84ab-79c3049803d0.png"> 

## Requirements

 Gitignore file used to push this repository, please include necessary frameworks in your pod file and install them to run the project. 
 Also keys.plist file containing API key is not included in this public repository. Please request your own API key from the "https://www.themoviedb.org/"
 Once you sign up, it's easy to get an api key by: Your Profile > Settings > API  ("https://developers.themoviedb.org/3/getting-started/introduction")
 
 Minimum IOS deployment target 13.2 and support both Iphone and Ipad. No 3rd party libraries were used for this app.
 XCode 11.2+ Swift 5.0+

## License

This app is open source. If you find a bug please open an issue. Feel free to contribute.
*Please check Report.pdf file for detailed information about the devolopment process. 
