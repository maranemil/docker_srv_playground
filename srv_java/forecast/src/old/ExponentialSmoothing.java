import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> data = new ArrayList<Integer>();
        data.add(10);
        data.add(15);
        data.add(20);
        data.add(25);
        data.add(30);
        double alpha = 0.5;
        int forecastPeriods = 2;
        ArrayList<Double> resultCalculation = exponentialSmoothing(data, alpha);
        ArrayList<Double> resultForecast = exponentialSmoothingForecast(data, alpha, forecastPeriods);
        System.out.println(resultCalculation);
    }

    public static ArrayList<Double> exponentialSmoothing(ArrayList<Integer> data, double alpha) {
        ArrayList<Double> smoothedData = new ArrayList<Double>();
        smoothedData.add((double) data.get(0));
        for (int i = 1; i < data.size(); i++) {
            double smoothedValue = alpha * data.get(i) + (1 - alpha) * smoothedData.get(i - 1);
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
