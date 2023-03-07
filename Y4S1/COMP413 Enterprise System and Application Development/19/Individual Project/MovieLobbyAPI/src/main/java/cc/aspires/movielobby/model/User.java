package cc.aspires.movielobby.model;

import jakarta.persistence.*;

@Entity
@Table(name = "User")
public class User {

    @Id
    @Column(name = "email")
    private String email;

    @Column(name = "hashedPassword")
    private String hashedPassword;

    @Column(name = "token")
    private double token;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public double getToken() {
        return token;
    }

    public void setToken(double token) {
        this.token = token;
    }
}
