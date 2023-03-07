package cc.aspires.movielobby.model;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class UserModel {
    public static String loginCheck(String email, String hashedPassword) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        User user = entityManager.find(User.class, email);
        entityManager.close();
        entityManagerFactory.close();

        if (user == null) { return "no_user"; }

        if (user.getHashedPassword().equals(hashedPassword)) {
            return "authenticated";
        } else {
            return "invalid_password";
        }
    }

    public static String signup(String email, String hashedPassword) {
        User user = new User();
        user.setEmail(email);
        user.setHashedPassword(hashedPassword);
        String res;
        try {
            EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
            EntityManager entityManager = entityManagerFactory.createEntityManager();
            entityManager.getTransaction().begin();
            entityManager.persist(user);
            entityManager.getTransaction().commit();
            res = "success";
            entityManager.close();
            entityManagerFactory.close();
        } catch (Exception e) {
            res = "duplicate";
        }
        return res;
    }

    public static String adjustToken(String email, double token) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        User user = entityManager.find(User.class, email);
        entityManager.close();
        entityManagerFactory.close();
        user.setToken(user.getToken() + token);
        EntityManagerFactory entityManagerFactory2 = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager2 = entityManagerFactory2.createEntityManager();
        entityManager2.getTransaction().begin();
        entityManager2.merge(user);
        entityManager2.getTransaction().commit();
        entityManager2.close();
        entityManagerFactory2.close();
        return "success";
    }

    public static String getToken(String email) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        User user = entityManager.find(User.class, email);
        entityManager.close();
        entityManagerFactory.close();
        if (user == null) { return "no_user"; }
        return String.valueOf(user.getToken());
    }

    public static User getUserByEmail(String email) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        User user = entityManager.find(User.class, email);
        entityManager.close();
        entityManagerFactory.close();
        return user;
    }

    public static void main(String[] args) throws Exception {
        System.out.println(signup("me@aspires.cc", "123456"));
        System.out.println(adjustToken("me@aspires.cc", 100));
    }
}
