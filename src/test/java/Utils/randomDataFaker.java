package Utils;

import net.datafaker.Faker;

public class randomDataFaker {

	
	static Faker fake = new Faker();
	
	
	public randomDataFaker() {
	}
	public static void main(String[] args) {
	}

	
	public static String generateRandomID(int digit) {
		return fake.number().digits(digit);
	}
	
	public static String generateRandomName() {
		return fake.name().fullName();
	}
}
