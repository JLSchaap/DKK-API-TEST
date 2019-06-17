import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit4.Karate;

import static org.junit.Assert.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.core.appender.rolling.FileSize;
import org.junit.Test;
import org.junit.runner.RunWith;

import net.masterthought.cucumber.Configuration;
import ch.qos.logback.classic.gaffer.ConfigurationContributor;
import cucumber.api.CucumberOptions;
/*
@RunWith(Karate.class)
@CucumberOptions(tags = {"~@TEMPLATE","~SMOKE","~BUG","@WIPTEST"})
public class ApiTest {
} 
*/
import net.masterthought.cucumber.ReportBuilder;

@CucumberOptions(tags = { "SMOKE", "~@TEMPLATE", "~WIP", "~BUG", "~@WIPTEST" })

public class ApiTest {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 20, "target/surefire-reports");
        generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "DKK API TEST");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}