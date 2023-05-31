import java.util.Arrays;
import java.util.*;
import java.util.ArrayList;
import java.util.Random;

public class Main {
    public static double[] exponentialMovingAverageForecast(double[] data, int periods, int forecastPeriods) {
        double alpha = 2.0 / (periods + 1);
        double[] ema = Arrays.copyOfRange(data, 0, periods);
        double[] forecast = new double[forecastPeriods];
        ema = Arrays.copyOf(ema, ema.length + 1);
        ema[ema.length - 1] = Arrays.stream(ema).sum() / periods;
        for (int i = periods; i < data.length + forecastPeriods; i++) {
            double emaValue = Math.round(alpha * data[i] + (1 - alpha) * ema[i - 1]) * 100.0 / 100.0;
            ema = Arrays.copyOf(ema, ema.length + 1);
            ema[ema.length - 1] = emaValue;
            if (i >= data.length) {
                forecast[i - data.length] = emaValue;
            }
        }
        return forecast;
    }

    public static double[] exponentialMovingAverage(double[] data, int periods) {
        double alpha = 2.0 / (periods + 1);
        double[] ema = Arrays.copyOfRange(data, 0, periods);
        for (int i = 1; i < data.length; i++) {
            ema = Arrays.copyOf(ema, ema.length + 1);
            ema[ema.length - 1] = Math.round(alpha * data[i] + (1 - alpha) * ema[i - 1]) * 100.0 / 100.0;
        }
        return ema;
    }

    public static void main(String[] args) {
        /*
         * Expected    [2,3, 4.5, 6.25, 9.12, 11.56, 13.78, 15.89, 17.94]
         * Calculated: [2.0, 4.0, 6.0, 3.0, 5.0, 7.0, 8.0, 10.0, 12.0, 13.0, 15.0] X
         * */
        double[] data = {2.0, 4.0, 6.0, 8.0, 12.0, 14.0, 16.0, 18.0, 20.0};
        int periods = 3;
        int forecastPeriods = 2;
        double[] resultCalculation = exponentialMovingAverage(data, periods);
        //double[] resultForecast = exponentialMovingAverageForecast(resultCalculation, periods, forecastPeriods);
        System.out.println("EMA Data: " + Arrays.toString(data));
        System.out.println("EMA Calculation: " + Arrays.toString(resultCalculation));
        //System.out.println(Arrays.toString(resultForecast));
    }
}
