package app.repositories;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;

public class UserRepositoryImplTest {

    @Test public void fakeTest() {
  		assertNotNull("put something real.", new UserRepositoryImpl(null));
  	}
}

