/* https://www.codeconvert.ai/php-to-java-converter */
import java.util.ArrayList;
import java.util.List;
import java.util.*;

public class MovingAverage {
    public static List<Double> calculateMovingAverage(List<Double> data, int windowSize) {
        List<Double> movingAverage = new ArrayList<>();
        int numDataPoints = data.size();
        // Calculate the moving average for the existing dataset
        for (int i = windowSize - 1; i < numDataPoints; i++) {
            double sum = 0;
            for (int j = i; j >= i - (windowSize - 1); j--) {
                sum += data.get(j);
            }
            double average = sum / windowSize;
            movingAverage.add(Math.round(average * 100.0) / 100.0);
        }
        return movingAverage;
    }

    public static List<Double> forecastMovingAverage(List<Double> movingAverage, int forecastSize) {
        int numMovingAverage = movingAverage.size();
        List<Double> forecast = new ArrayList<>();
        // Forecast future values based on the moving average
        for (int i = 0; i < forecastSize; i++) {
            double sum = 0;
            int start = numMovingAverage - (i + 1);
            int end = start - (forecastSize - 1);
            for (int j = start; j >= end; j--) {
                sum += movingAverage.get(j);
            }
            double average = sum / forecastSize;
            forecast.add(Math.round(average * 100.0) / 100.0);
        }
        return forecast;
    }

    public static void main(String[] args) {
        /*
        Data: [2.0, 4.0, 6.0, 8.0, 12.0, 14.0, 16.0, 18.0, 20.0]
        Moving Average: [4.0, 6.0, 8.67, 11.33, 14.0, 16.0, 18.0]
        Forecast: [17.0, 15.0]

        Expected [2,3, 4.5, 6.25, 9.12, 11.56, 13.78, 15.89, 17.94]
        Calculated:   [4.0, 6.00, 8.67, 11.33, 14.00, 16.00, 18.00] OK
        */

        //List<Double> data = new ArrayList<>();
        //data.add(17.0);
        List<Double> data = Arrays.asList(2.0, 4.0, 6.0, 8.0, 12.0, 14.0, 16.0, 18.0, 20.0);
        int windowSize = 3;
        int forecastSize = 2;
        List<Double> movingAverage = calculateMovingAverage(data, windowSize);
        List<Double> forecast = forecastMovingAverage(movingAverage, forecastSize);
        /*System.out.println("Data: " + data);
        System.out.println("Moving Average: " + movingAverage);
        System.out.println("Forecast: " + forecast);*/
    }
}

