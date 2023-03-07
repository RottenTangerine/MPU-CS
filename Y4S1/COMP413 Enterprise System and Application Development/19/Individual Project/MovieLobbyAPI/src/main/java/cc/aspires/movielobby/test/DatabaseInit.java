package cc.aspires.movielobby.test;

import cc.aspires.movielobby.model.*;

public class DatabaseInit {
    public static void main(String[] args) {
        Movie movie = new Movie();
        movie.setTitle("The Matrix");
        movie.setId("tt0133093");
        movie.setYear(1999);
        movie.setDirector("Wachowski Brothers");
        movie.setGenre("Action");
        movie.setCoverImage("https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg");
        movie.setTrailer("https://www.youtube.com/watch?v=m8e-FF8MsqU");
        movie.setStudio("Warner Bros.");
        movie.setDescription("A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.");
        movie.setRentalPrice(2.99);
        movie.setRunLength(136);

        MovieModel.addMovie(movie);

        UserModel.signup("me@aspires.cc", "123456");
        MovieRentalModel.createMovieRental("tt0133093", "me@aspires.cc");

    }
}
