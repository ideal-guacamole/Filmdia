package entityVO;

/**
 * Created by mac on 2017/5/25.
 */
public class ReviewDistribute {
    private String country;
    private int number;

    public ReviewDistribute() {
    }

    public ReviewDistribute(String country, int number) {
        this.country = country;
        this.number = number;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
