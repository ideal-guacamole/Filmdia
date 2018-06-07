package Util;

import java.net.URL;

/**
 * Created by mac on 2017/6/3.
 */
public class Path {

    public static String getProjectPath() {
        String path = Path.class.getProtectionDomain().getCodeSource().getLocation().getFile();
        if (path.contains("ROOT")) {
            path = path.split("ROOT")[0] + "ROOT/";
        } else {
            path = path.split("Filmdia_Iteration_III")[0] + "Filmdia_Iteration_III/";
        }
//        DebugOutput.output(path + '\n');
        return path;
    }
}
