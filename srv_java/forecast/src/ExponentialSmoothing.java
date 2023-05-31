
import java.util.ArrayList;
import java.util.*;

public class Main {
    public static void main(String[] args) {

        /*
        * Expected   [2,   3,   4.5, 6.25, 9.125, 11.56, 13.78, 15.89, 17.94]
        * Calculated [2.0, 3.0, 5.0, 7.0,  10.0,  12.0,  14.0,  16.0,  18.0] OK
        * */

        /*ArrayList<Integer> data = new ArrayList<Integer>();
        data.add(10);
        data.add(15);*/

        // https://www.dotnetperls.com/arraylist-integer-java
        int[] ids = {2, 4, 6, 8, 12, 14, 16, 18, 20};
        ArrayList<Integer> data = new ArrayList<>();
        for (int id: ids) {
            data.add(id);
        }
        double alpha = 0.5;
        int forecastPeriods = 2;
        ArrayList<Double> resultCalculation = exponentialSmoothing(data, alpha);
        ArrayList<Double> resultForecast = exponentialSmoothingForecast(data, alpha, forecastPeriods);
        System.out.println("ES Data: " + data);
        System.out.println("ES Calculation: " + resultCalculation);
        System.out.println("ES Forecast: " + resultForecast);
    }

    public static ArrayList<Double> exponentialSmoothing(ArrayList<Integer> data, double alpha) {
        ArrayList<Double> smoothedData = new ArrayList<Double>();
        smoothedData.add((double) data.get(0));
        for (int i = 1; i < data.size(); i++) {
            double smoothedValue = Math.round(alpha * data.get(i) + (1 - alpha) * smoothedData.get(i - 1)* 100/100);
            smoothedData.add(smoothedValue);
        }
        return smoothedData;
    }

    public static ArrayList<Double> exponentialSmoothingForecast(ArrayList<Integer> data, double alpha, int forecastPeriods) {
        ArrayList<Double> forecast = new ArrayList<Double>();
        if (alpha < 0 || alpha > 1) {
            throw new IllegalArgumentException("Invalid alpha value.");
        }
        forecast.add((double) data.get(0));
        for (int i = 1; i <= forecastPeriods; i++) {
            double forecastValue = alpha * data.get(data.size() - 1) + (1 - alpha) * forecast.get(i - 1);
            forecast.add(forecastValue);
        }
        return forecast;
    }
}
