import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.Assert.*;
import org.junit.Test;

import cucumber.api.CucumberOptions;

/* 
@RunWith(Karate.class)
//@CucumberOptions(tags = "~@bug")
public class ApiTest {
} */

@CucumberOptions(tags = {"~@TEMPLATE","~@WIP"})
public class ApiTest {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 20, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

}