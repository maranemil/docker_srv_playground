import java.util.ArrayList;
import java.util.List;

public class ExponentialMovingAverage {

    public static List<Double> exponentialMovingAverageForecast(List<Double> data, int periods, int forecastPeriods) {
        double alpha = 2.0 / (periods + 1);
        List<Double> ema = data.subList(0, periods);
        List<Double> forecast = new ArrayList<>();
        ema.add(ema.stream().mapToDouble(Double::doubleValue).sum() / periods);
        for (int i = periods; i < data.size() + forecastPeriods; i++) {
            double emaValue = Math.round(alpha * data.get(i) + (1 - alpha) * ema.get(i - 1)) * 100.0 / 100.0;
            ema.add(emaValue);
            if (i >= data.size()) {
                forecast.add(emaValue);
            }
        }
        return forecast;
    }

    public static List<Double> exponentialMovingAverage(List<Double> data, int periods) {
        double alpha = 2.0 / (periods + 1);
        List<Double> ema = data.subList(0, periods);
        for (int i = 1; i < data.size(); i++) {
            ema.set(i, Math.round(alpha * data.get(i) + (1 - alpha) * ema.get(i - 1)) * 100.0 / 100.0);
        }
        return ema;
    }

    // Example usage
    // List<Double> data = Arrays.asList(2, 4, 6, 8, 12, 14, 16, 18, 20);
    // int periods = 3;
    // int forecastPeriods = 2;
    // List<Double> resultCalculation = exponentialMovingAverage(data, periods);
    // List<Double> resultForecast = exponentialMovingAverageForecast(data, periods, forecastPeriods);
}
