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
//		return Karate.run(featureFile+"getResponseApi.feature");						
//    }
    
//    @Karate.Test
//    Karate getDataFromConfigApi() {
//		return Karate.run(featureFile+"scenario.feature");						
//    }
    
//    @Karate.Test
//    Karate queryApi() {
//		return Karate.run(featureFile+"queryApi.feature");						
//    }
    
//    @Karate.Test
//    Karate requestHeadersApi() {
//		return Karate.run(featureFile+"requestHeaders.feature");						
//    }
    
//    @Karate.Test
//    Karate postapi() {
//		return Karate.run(featureFile+"post.feature");						
//    }
    
//    @Karate.Test
//    Karate verifyTheResponse() {
//		return Karate.run(featureFile+"verifyTheResponse.feature");						
//    }
	
//	  @Karate.Test
//	  Karate putapi() {
//			return Karate.run(featureFile+"put.feature");						
//	  }	
	
//	  @Karate.Test
//	  Karate variable() {
//			return Karate.run(featureFile+"variable.feature");						
//	  }
	
//	  @Karate.Test
//	  Karate deleteapi() {
//			return Karate.run(featureFile+"delete.feature");						
//	  }	
	  
//	  @Karate.Test
//	  Karate readExternalFileapi() {
//			return Karate.run(featureFile+"ReadExternalFile.feature");						
//	  }	
	  
//	  @Karate.Test
//	  Karate CreateNestedJsonObjectapi() {
//			return Karate.run(featureFile+"CreateNestedJsonObject.feature");						
//	  }	
	  
	  @Karate.Test
	  Karate generateRandomValuesUsingDataFakerapi() {
			return Karate.run(featureFile+"GenerateRandomValuesforPayloadUsingDataFaker.feature");						
	  }	
}
