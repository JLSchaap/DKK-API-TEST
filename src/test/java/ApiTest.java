import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit4.Karate;

import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
/*
@RunWith(Karate.class)
@CucumberOptions(tags = {"~@TEMPLATE","~SMOKE","~BUG","@WIPTEST"})
public class ApiTest {
} 
*/

@CucumberOptions(tags = { "SMOKE", "~@TEMPLATE", "~WIP", "~BUG", "~@WIPTEST" })

public class ApiTest {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 20, "target/surefire-reports");

        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

}
