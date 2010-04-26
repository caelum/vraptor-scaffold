package br.com.vraptor;

import static br.com.vraptor.test.TestHelper.deleteFile;
import static org.junit.Assert.assertTrue;

import java.io.File;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * Tests to {@link Scaffold}.
 */
public class ScaffoldTest {
	
	private String projectName;
	private String[] args;
	
	@Before
	public void before() {
		projectName = "home";
		args = new String[] { projectName };
	}
	
	@After
	public void after() {
		deleteFile(projectName);
	}

	@Test
	public void shouldCreateProjectFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists project folder.", new File(projectName).exists());
	}
	
	@Test
	public void shouldCreateJavaSourceFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists java source folder.", new File(projectName + "/src/main/java").exists());
	}
	
	@Test
	public void shouldCreateMainResourceFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists main resource folder.", new File(projectName + "/src/main/resource").exists());
	}
	
	@Test
	public void shouldCreateWebXml() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists web.xml.", new File(projectName + "/src/main/webapp/WEB-INF/web.xml").exists());
	}
	
	@Test
	public void shouldCreatePomXml() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists pom.xml.", new File(projectName + "/pom.xml").exists());
	}
	
}