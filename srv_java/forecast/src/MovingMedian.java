import java.util.Arrays;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        /*
        Expected  [2, 4, 4, 6, 8, 12, 14, 16, 18, 20]
        Calculated:  [4, 4, 6, 8, 12, 14, 16, 18, 20] OK
        */
        int[] data = {2, 4, 6, 8, 12, 14, 16, 18, 20};
        int windowSize = 3;
        int forecastPeriods = 2;
        int[] resultCalculation = movingMedian(data, windowSize);

        // https://www.softwaretestinghelp.com/reverse-an-array-in-java/
        /*int j = 0;
        int[]  resultCalculationInvert = new int[resultCalculation.length];
        for(int i=resultCalculation.length-1;i>=0;i--){
            resultCalculationInvert[j] = resultCalculation[i];
            j=j+1;
        }*/
        //System.out.println(Arrays.toString(resultCalculationInvert));
        int[] resultForecast = movingMedianForecast(resultCalculation, windowSize, forecastPeriods);
        System.out.println("MM Data: " + Arrays.toString(data));
        System.out.println("MM Calculation: " + Arrays.toString(resultCalculation));
        System.out.println("MM Forecast: " + Arrays.toString(resultForecast));
    }

    public static int[] movingMedianForecast(int[] data, int windowSize, int forecastPeriods) {
        int[] forecast = new int[forecastPeriods];
        Arrays.sort(data);
        for (int i = 0; i < forecastPeriods; i++) {
            int[] window = Arrays.copyOfRange(data, i, i + windowSize);
            int median = calculateMedian(window);
            forecast[i] = median;
        }
        Arrays.sort(forecast);
        return forecast;
    }

    public static int[] movingMedian(int[] data, int windowSize) {
        int numData = data.length;
        int halfWindowSize = windowSize / 2;
        int[] movingMedians = new int[numData];
        for (int i = 0; i < numData; i++) {
            int startIndex = Math.max(0, i - halfWindowSize);
            int endIndex = Math.min(numData - 1, i + halfWindowSize);
            int[] window = Arrays.copyOfRange(data, startIndex, endIndex + 1);
            Arrays.sort(window);
            int medianIndex = window.length / 2;
            movingMedians[i] = window[medianIndex];
        }
        return movingMedians;
    }

    public static int calculateMedian(int[] data) {
        Arrays.sort(data);
        int count = data.length;
        int middle = (count - 1) / 2;
        int median;
        if (count % 2 == 0) {
            median = Math.round((data[middle] + data[middle + 1]) / 2);
        } else {
            median = data[middle];
        }
        return median;
    }
}