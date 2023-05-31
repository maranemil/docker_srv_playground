/* https://www.codeconvert.ai/php-to-java-converter */

import java.util.ArrayList;
import java.util.Arrays;

public void errorsCalculator(ArrayList<Double> data, ArrayList<Double> resultCalculation, int windows_size) {
    ArrayList<Double> arrCalc = new ArrayList<>(data.subList(windows_size, data.size()));
    ArrayList<Double> arErr = new ArrayList<>();
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
