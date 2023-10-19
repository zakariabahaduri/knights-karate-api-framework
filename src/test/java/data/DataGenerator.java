package data;

import com.github.javafaker.Faker;
import com.github.javafaker.Name;

import java.sql.SQLOutput;

public class DataGenerator {
    public static String getEmail() {
//        instructor_mohammad_82710@tekschool.us
        String email = "Brandon_Thompson_";
        int random = (int) (Math.random() * 8921000);
        return email + random + "@tekschool.us";
    }
  /*  public static String getFirstName() {

        char [] alphabets = {'A','B','G','S','D'};
        String name = "";
        for (int i=0; i<alphabets.length; i++) {
            int index = (int) (Math.random() * 5);
            name += alphabets[index];
        }
        return name;
    }

   */

    public static String getFirstName() {
        Faker faker = new Faker();
       return faker.name().firstName();

    }
}
