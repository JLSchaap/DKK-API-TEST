
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import static org.junit.Assert.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;

import org.junit.Test;

import net.masterthought.cucumber.Configuration;

import cucumber.api.CucumberOptions;
/*
@RunWith(Karate.class)
@CucumberOptions(tags = {"~@TEMPLATE","~SMOKE","~BUG","@WIPTEST"})
public class ApiTest {
} 
*/
import net.masterthought.cucumber.ReportBuilder;

@CucumberOptions(tags = { "SMOKE", "~@TEMPLATE", "~WIP", "~BUG", "~@WIPTEST" })

/*

@CucumberOptions(tags = {  "WIPx"})
*/ 

public class ApiTest {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 5, "target/surefire-reports");
        generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }


    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File(karateOutputPath), "DKK API TEST");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}