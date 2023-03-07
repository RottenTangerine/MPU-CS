package cc.aspires.movielobby.controller;

import cc.aspires.movielobby.model.UserModel;
import cc.aspires.movielobby.model.User;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

@Path("/user")
public class UserResource {

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/login")
    public String loginCheck(User user) {
        String response = UserModel.loginCheck(user.getEmail(), user.getHashedPassword());
        return "{'response': " + response + "}";
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/signup")
    public String signup(User user) throws Exception {
        String response = UserModel.signup(user.getEmail(), user.getHashedPassword());
        return "{'response': " + response + "}";
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/token/{email}")
    public String getToken(@PathParam("email") String email) {
        String response = UserModel.getToken(email);
        return response;
    }

    @GET
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/token/topup/{email}/{value}")
    public String topupToken(@PathParam("email") String email, @PathParam("value") double value) {
        String response = UserModel.adjustToken(email, value);
        return "{'response': " + response + "}";
    }

}