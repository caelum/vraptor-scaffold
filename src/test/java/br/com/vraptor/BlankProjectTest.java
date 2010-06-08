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
	public void before() throws IOException {
		blankProject = new BlankProject("vraptor-scaffold");
		blankProject.createProject();
	}
	
	@After
	public void after() throws IOException {
		FileUtils.deleteDirectory(new File(projectName));
		FileUtils.deleteDirectory(new File("src/main/java/app"));
		FileUtils.deleteDirectory(new File("src/main/webapp"));
	}
	
	@Test
	public void shouldCreateProjectFolder() throws Exception {
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
		blankProject.createPom();
		assertTrue("Should create pom xml.", new File(projectName + "/pom.xml").exists());
		assertTrue("Should create pom xml.", FileUtils.contentEquals(new File("src/test/resources/pom.xml"),  new File(projectName + "/pom.xml")));
	}
	
	@Test
	public void shouldCreateWebXml() throws Exception {
		blankProject.createWebApp();
		File webXml = new File(projectName + "/src/main/webapp/WEB-INF/web.xml");
		assertTrue("Should create web xml.", webXml.exists());
		assertTrue("Should create web xml.", FileUtils.contentEquals(new File("src/main/resources/scaffold/WEB-INF/web.xml"),  webXml));
	}
	
	@Test
	public void shouldCreateDecoratorsXml() throws Exception {
		blankProject.createWebApp();
		assertTrue("Should exists decorators.xml.", new File(projectName + "/src/main/webapp/WEB-INF/decorators.xml").exists());
	}

	@Test
	public void shouldCreateDecorator() throws Exception {
		blankProject.createWebApp();
		assertTrue("Should exists decorator.", new File(projectName + "/src/main/webapp/decorators/main.ftl").exists());
	}

	@Test
	public void shouldCreateIndex() throws Exception {
		blankProject.createWebApp();
		assertTrue("Should exists index.jsp.", new File(projectName + "/src/main/webapp/index.jsp").exists());
	}
	
	@Test
	public void shouldCreateLog4j() throws Exception {
		blankProject.createMainResources();
		assertFile("Should exists log4j.xml.", projectName + "/src/main/resources/log4j.xml", 
				"src/main/resources/scaffold/log4j.xml");
	}
	
	@Test
	public void shouldCreatePersistenceXml() throws Exception {
		blankProject.createMainResources();
		assertFile("Should exists persistence.xml.", projectName + "/src/main/resources/META-INF/persistence.xml", 
				"src/main/resources/scaffold/META-INF/persistence.xml");
	}
	
	@Test 
	public void shouldCreateModelFolder() throws Exception {
		blankProject.createMainJava();
		assertTrue("Should exists model folder.", new File(projectName + "/src/main/java/app/models").exists());
	}

	@Test
	public void shouldCreateControllerFolder() throws Exception {
		blankProject.createMainJava();
		assertTrue("Should exists controller folder.", new File(projectName + "/src/main/java/app/controllers").exists());
	}
	
	@Test
	public void shouldCreateFreemarkerPathResolver() throws Exception {
		blankProject.createMainJava();
		assertFile("Should exists path resolver.", 
				"src/main/resources/scaffold/TemplatePathResolver.ftl", projectName + "/src/main/java/app/infrastructure/FreemarkerPathResolver.ftl");
	}
	
	private void assertFile(String msg, String expeted, String file) throws IOException {
		assertTrue(msg, FileUtils.contentEquals(new File(expeted),  new File(file)));
	}
}