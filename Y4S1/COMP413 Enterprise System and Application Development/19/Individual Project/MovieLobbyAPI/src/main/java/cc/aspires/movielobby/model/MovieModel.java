package cc.aspires.movielobby.model;

import com.google.gson.Gson;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class MovieModel {
    
    public static String getAllMovies() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Movie> movies = entityManager.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
        entityManager.close();
        entityManagerFactory.close();
        String json = new Gson().toJson(movies);
        return json;
    }

    public static String addMovie(Movie movie) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        String res;
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(movie);
            entityManager.getTransaction().commit();
            res = "success";
        } catch (Exception e) {
            res = "failed";
        }
        entityManager.close();
        entityManagerFactory.close();
        return res;
    }

    public static Movie getMovieById(String movieId) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Movie movie = entityManager.find(Movie.class, movieId);
        entityManager.close();
        entityManagerFactory.close();
        return movie;
    }
}
