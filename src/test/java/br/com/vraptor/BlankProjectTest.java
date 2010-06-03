package br.com.vraptor;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * Tests to {@link BlankProject}.
 */
public class BlankProjectTest {
	
	private BlankProject blankProject;
	private String projectName = "vraptor-scaffold";
	
	@Before
	public void before() {
		blankProject = new BlankProject("vraptor-scaffold");
	}
	
	@After
	public void after() throws IOException {
		FileUtils.deleteDirectory(new File(projectName));
	}
	
	@Test
	public void shouldCreateProjectFolder() throws Exception {
		blankProject.createProject();
		assertTrue("Should exists project folder.", new File(projectName).exists());
	}

	@Test
	public void shouldCreateMainJavaSourceFolder() throws Exception {
		blankProject.createMainJava();
		assertTrue("Should exists main java source folder.", new File(projectName + "/src/main/java").exists());
	}

	@Test
	public void shouldCreateMainResourcesFolder() throws Exception {
		blankProject.createMainResources();
		assertTrue("Should exists main resource folder.", new File(projectName + "/src/main/resources").exists());
	}

	@Test
	public void shouldCreateJavaTestSourceFolder() throws Exception {
		blankProject.createTestJava();
		assertTrue("Should exists test java source folder.", new File(projectName + "/src/test/java").exists());
	}

	@Test
	public void shouldCreateTestResourcesFolder() throws Exception {
		blankProject.createTestResources();
		assertTrue("Should exists test resources folder.", new File(projectName
				+ "/src/test/resources").exists());
	}
	
	@Test
	public void shouldGeneratePom() throws Exception {
		blankProject.createProject();
		blankProject.createPom();
		assertTrue("Should create pom xml.", new File(projectName + "/pom.xml").exists());
		assertTrue("Should create pom xml.", FileUtils.contentEquals(new File("src/test/resources/pom.xml"),  new File(projectName + "/pom.xml")));
	}
}