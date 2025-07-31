package runnerPackage;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	public static String featureFile = "classpath:featureFile/";     // or "src/test/resources/featureFile/"
	
//    @Karate.Test
//    Karate testApi() {
//    	// return Karate.run("featureFile/getApi1").relativeTo(getClass());				// works if the .feature file exist in same package
//		return Karate.run(featureFile+"getApi.feature");								// works if the .feature file exist in different package
//    }
    
//    @Karate.Test
//    Karate getResponseApi() {
//		return Karate.run(featureFile+"getResponseApi.feature");						// works if the .feature file exist in different package
//    }
    
//    @Karate.Test
//    Karate getDataFromConfigApi() {
//		return Karate.run(featureFile+"scenario.feature");						// works if the .feature file exist in different package
//    }
    
    @Karate.Test
    Karate queryApi() {
		return Karate.run(featureFile+"queryApi.feature");						// works if the .feature file exist in different package
    }
    
    
}
