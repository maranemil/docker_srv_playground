import java.util.ArrayList;
import java.util.List;

public class MovingAverageCalculator {
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

    public static void main(String[] args) {
        int windowSize = 3;
        int forecastSize = 2;
        List<Double> data = new ArrayList<>();
        // add data to the list
        List<Double> resultCalculation = calculateMovingAverage(data, windowSize);
        List<Double> resultForecast = forecastMovingAverage(resultCalculation, forecastSize);
        System.out.println(resultCalculation);
    }
}
