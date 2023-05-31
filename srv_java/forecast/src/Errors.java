/*
 https://www.codeconvert.ai/php-to-java-converter
 https://www.jdoodle.com/online-java-compiler/
 https://www.tutorialspoint.com/online_java_formatter.htm
*/

import java.util.ArrayList;
import java.util.List;
import java.util.*;

public class MyClass {

    public static void main(String[] args) {
        /*
         Expected [2,3, 4.5, 6.25, 9.12, 11.56, 13.78, 15.89, 17.94]
         Calculated [   4.0, 6.0,  8.67, 11.33, 14.0,  16.0,  18.0]   OK
        */
        int windowSize = 3;
        int forecastSize = 3;
        List < Double > data = Arrays.asList(2.0, 3.0, 4.5, 6.25, 9.12, 11.56, 13.78, 15.89, 17.94);
        List < Double > resultCalculation = Arrays.asList(4.0, 6.0, 8.67, 11.33, 14.0, 16.0, 18.0);
        errorsCalculator(data, resultCalculation, windowSize);
        /*System.out.println("MA Data" + data);
        System.out.println("MA Calculation" + resultCalculation);*/
    }


    public static void errorsCalculator(List < Double > data, List < Double > resultCalculation, int windows_size) {
        //System.out.println( data);
        ArrayList < Double > arrCalc = new ArrayList < > (data.subList(windows_size, data.size()));
        ArrayList < Double > arErr = new ArrayList < > ();
        for (int i = 0; i < resultCalculation.size(); i++) {
            if (arrCalc.size() > i) {
                double error1 = arrCalc.get(i) - resultCalculation.get(i);
                double error2 = Math.round(error1 * error1 * 100.0) / 100.0;
                double percent = Math.round(((arrCalc.get(i) - resultCalculation.get(i)) / arrCalc.get(i)) * 10000.0) / 100.0;
                arErr.add(error1);
                arErr.add(error2);
                arErr.add(percent);
            }
        }
        int errors_cnt = arErr.size() / 3;
        System.out.println("<br> Errors Count: " + errors_cnt);
        double errors_tot = Math.round(arErr.stream().mapToDouble(Double::doubleValue).sum() * 1000.0) / 1000.0;
        System.out.println("<br> Errors Total: " + errors_tot);
        double MAE = Math.round(errors_tot / errors_cnt * 100.0) / 100.0;
        System.out.println("<br>MAE: " + MAE);
        double MSE = Math.round(arErr.stream().skip(1).filter(i -> arErr.indexOf(i) % 3 == 1).mapToDouble(Double::doubleValue).sum() / errors_cnt * 100.0) / 100.0;
        System.out.println("<br>MSE: " + MSE);
        double RMSE = Math.round(Math.sqrt(MSE) * 100.0) / 100.0;
        System.out.println("<br>RMSE: " + RMSE);
        double MAPE = Math.round(arErr.stream().skip(2).filter(i -> arErr.indexOf(i) % 3 == 2).mapToDouble(Double::doubleValue).sum() / errors_cnt * 100.0) / 100.0;
        System.out.println("<br>MAPE: " + MAPE);
    }
}

/*
<br> Errors Count: 6
<br> Errors Total: 186.7
<br>MAE: 31.12
<br>MSE: 6.08
<br>RMSE: 2.47
<br>MAPE: 22.62
*/