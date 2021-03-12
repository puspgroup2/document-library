package tests;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import database.DataBase;

class FT2 {
	private DataBase malte;

	@BeforeEach
	void setUp() throws Exception {
		malte = new DataBase(); 
		malte.connect();	//Must change connection in DataBase class so that it connects
	}

	@AfterEach
	void tearDown() throws Exception {
		malte.disconnect();
	}

	@Test
	void UnsuccessfullLogin() {
		assertFalse(malte.checkLogin("Malte", "123ABCde"), "You got logged in.");
	}

}

