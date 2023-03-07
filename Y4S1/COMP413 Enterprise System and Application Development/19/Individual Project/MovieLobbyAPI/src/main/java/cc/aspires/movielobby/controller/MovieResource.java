package cc.aspires.movielobby.controller;

import cc.aspires.movielobby.model.MovieModel;
import cc.aspires.movielobby.model.Movie;
import com.google.gson.Gson;
import jakarta.ws.rs.*;

@Path("/movie")
public class MovieResource {
    @GET
    @Produces("application/json")
    @Path("/all")
    public String getAllMovies() {
        String json = MovieModel.getAllMovies();
        return "{\"all\": " + json + "}";
    }

    @POST
    @Consumes("application/json")
    @Produces("application/json")
    @Path("/add")
    public String addMovie(Movie movie) {
        String response = MovieModel.addMovie(movie);
        return "{\"response\": " + response + "}";
    }

    @GET
    @Produces("application/json")
    @Path("/get/{id}")
    public String getMovieById(@PathParam("id") String id) {
        Movie json = MovieModel.getMovieById(id);
        return new Gson().toJson(json);
    }
}
