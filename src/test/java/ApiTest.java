import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.Assert.*;
import org.junit.Test;

/* 
@RunWith(Karate.class)
//@CucumberOptions(tags = "~@bug")
public class ApiTest {
} */

public class ApiTest {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 20, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

}