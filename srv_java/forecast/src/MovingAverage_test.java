/* https://www.codeconvert.ai/php-to-java-converter */

import java.util.ArrayList;
import java.util.List;

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
        List<Double> data = new ArrayList<>();
        data.add(17.0);
        data.add(19.0);
        data.add(26.0);
        data.add(12.0);
        data.add(18.0);
        data.add(20.0);
        data.add(15.0);
        data.add(22.0);
        data.add(17.0);
        data.add(21.0);
        data.add(16.0);
        int windowSize = 3;
        int forecastSize = 3;
        List<Double> movingAverage = calculateMovingAverage(data, windowSize);
        List<Double> forecast = forecastMovingAverage(movingAverage, forecastSize);
        System.out.println("Data: " + data);
        System.out.println("Moving Average: " + movingAverage);
        System.out.println("Forecast: " + forecast);
    }
}

