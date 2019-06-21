package download;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;

public class DataStorage {

    public String mywriteln(String str, String fileName) throws IOException {

        FileOutputStream fos = new FileOutputStream(fileName, true);
        fos.write(str.getBytes());
        fos.write(System.getProperty("line.separator").getBytes());
        fos.close();
        return "OK"; 
    }

}