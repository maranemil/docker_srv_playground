import java.util.ArrayList;
import java.util.List;
import java.util.*;

public class MovingAverageCalculator {

    public static void main(String[] args) {
        /*
         Expected [2,3, 4.5, 6.25, 9.12, 11.56, 13.78, 15.89, 17.94]
         Calculated [   4.0, 6.0,  8.67, 11.33, 14.0,  16.0,  18.0]   OK
        */
        int windowSize = 3;
        int forecastSize = 2;
        List<Double> data = Arrays.asList(2.0, 4.0, 6.0, 8.0, 12.0, 14.0, 16.0, 18.0, 20.0);
        List<Double> resultCalculation = calculateMovingAverage(data, windowSize);
        List<Double> resultForecast = forecastMovingAverage(resultCalculation, forecastSize);
        System.out.println("MA Data" + data);
        System.out.println("MA Calculation" + resultCalculation);
        System.out.println("MA Forecast" + resultForecast);
    }


    public static List<Double> calculateMovingAverage(List<Double> data, int windowSize) {
        List<Double> movingAverage = new ArrayList<>();
        int numDataPoints = data.size();
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


}
