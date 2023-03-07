package cc.aspires.movielobby.controller;

import cc.aspires.movielobby.model.MovieRentalModel;
import cc.aspires.movielobby.model.User;
import cc.aspires.movielobby.model.UserModel;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

@Path("/rental")
public class RentalResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/rent/{movieId}/{email}")
    public String rentMovie(@PathParam("movieId") String movieId, @PathParam("email") String email) {
        String response = MovieRentalModel.createMovieRental(movieId, email);
        return response;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/get/{email}")
    public String getMovieRentalByUserEmail(@PathParam("email") String email) {
        String response = MovieRentalModel.getMovieRentalByUserEmail(email);
        return response;
    }

}