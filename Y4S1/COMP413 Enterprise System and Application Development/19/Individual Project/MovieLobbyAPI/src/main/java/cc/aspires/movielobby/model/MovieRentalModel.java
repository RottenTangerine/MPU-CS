package cc.aspires.movielobby.model;

import com.google.gson.Gson;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class MovieRentalModel {

    public static String getMovieRentalByUserEmail(String userEmail) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<MovieRental> movieRentals = entityManager.createQuery("SELECT m FROM MovieRental m WHERE m.userEmail = :userEmail", MovieRental.class).setParameter("userEmail", userEmail).getResultList();
        entityManager.close();
        entityManagerFactory.close();
        String json = new Gson().toJson(movieRentals);
        return json;
    }

    public static String createMovieRental(String movieId, String userEmail) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String res;
        Movie movie = MovieModel.getMovieById(movieId);
        User user = UserModel.getUserByEmail(userEmail);
        user.setToken(user.getToken() - movie.getRentalPrice());
        if (user.getToken() < 0) {
            res = "Not enough token";
            return res;
        }
        UserModel.adjustToken(user.getEmail(), -movie.getRentalPrice());
        MovieRental movieRental = new MovieRental();
        movieRental.setMovieId(movieId);
        movieRental.setUserEmail(userEmail);
        movieRental.setRentalPrice(movie.getRentalPrice());
        movieRental.setId(System.currentTimeMillis());
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(movieRental);
            entityManager.getTransaction().commit();
            res = "success";
        } catch (Exception e) {
            System.out.println(e);
            res = "failed";
        }
        entityManager.close();
        entityManagerFactory.close();
        return res;
    }

}
