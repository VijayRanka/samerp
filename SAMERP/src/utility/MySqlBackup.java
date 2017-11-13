package utility;

import java.io.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.log4j.Logger;

public class MySqlBackup {

    //initializing the logger  
    static Logger log = Logger.getLogger(MySqlBackup.class.getName());

 
     public static void main(String[] args) throws SQLException {
        MySqlBackup b = new MySqlBackup();
        b.backupDataWithDatabase("C:\\xampp\\mysql\\bin\\mysqldump.exe", "localhost", "3306", "root", "", "samerp", "C:/Users/sandeep/Desktop/Backup/");
    }


    public boolean backupDataWithDatabase(String dumpExePath, String host, String port, String user, String password, String database, String backupPath) {
        boolean status = false;
        try {
            Process p = null;

            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String filepath = database + " database -(" + dateFormat.format(date) + ").sql";

            String batchCommand = "";
            if (password != "") {
                //Backup with database
                batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user + " --password=" + password + " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
            } else {
                batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user + " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
            }

            Runtime runtime = Runtime.getRuntime();
            p = runtime.exec(batchCommand);
            int processComplete = p.waitFor();


            if (processComplete == 0) {
                status = true;
                log.info("Backup created successfully for with DB " + database + " in " + host + ":" + port);
            } else {
                status = false;
                log.info("Could not create the backup for with DB " + database + " in " + host + ":" + port);
            }

        } catch (IOException ioe) {
            log.error(ioe, ioe.getCause());
        } catch (Exception e) {
            log.error(e, e.getCause());
        }
        return status;
    }
}