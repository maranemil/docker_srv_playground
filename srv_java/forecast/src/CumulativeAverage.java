import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> data = new ArrayList<>();
        /*2, 4, 6, 8, 12, 14, 16, 18, 20*/
        data.add(2);
        data.add(4);
        data.add(6);
        data.add(8);
        data.add(12);
        int forecastPeriods = 2;
        List<Double> resultCalculation = cumulativeAverage(data);
        List<Double> resultForecast = cumulativeAverageForecast(data, forecastPeriods);
        System.out.println(resultCalculation);
    }

    public static List<Double> cumulativeAverageForecast(List<Integer> data, int forecastPeriods) {
        List<Double> cumulativeAverage = cumulativeAverage(data);
        List<Double> forecast = new ArrayList<>();
        double lastValue = data.get(data.size() - 1);
        for (int i = 0; i < forecastPeriods; i++) {
            double forecastValue = Math.round((lastValue + cumulativeAverage.get(cumulativeAverage.size() - 1)) / 2 * 100.0) / 100.0;
            forecast.add(forecastValue);
            lastValue = forecastValue;
        }
        return forecast;
    }

    public static List<Double> cumulativeAverage(List<Integer> data) {
        List<Double> cumulativeAverage = new ArrayList<>();
        double sum = 0;
        for (int i = 0; i < data.size(); i++) {
            sum += data.get(i);
            cumulativeAverage.add(Math.round(sum / (i + 1) * 100.0) / 100.0);
        }
        return cumulativeAverage;
    }
}
