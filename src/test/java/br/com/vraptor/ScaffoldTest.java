package br.com.vraptor;

import static br.com.vraptor.test.TestHelper.deleteFile;
import static org.junit.Assert.*;
import static org.junit.Assert.assertTrue;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.jvnet.inflector.Noun.pluralOf;

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
		assertTrue("Should exists project folder.", new File(projectName)
				.exists());
	}

	@Test
	public void shouldCreateJavaSourceFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists java source folder.", new File(projectName
				+ "/src/main/java").exists());
	}

	@Test
	public void shouldCreateMainResourcesFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists main resource folder.", new File(projectName
				+ "/src/main/resources").exists());
	}

	@Test
	public void shouldCreateJavaTestSourceFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists java test source folder.", new File(
				projectName + "/src/test/java").exists());
	}

	@Test
	public void shouldCreateTestResourcesFolder() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists test resources folder.", new File(projectName
				+ "/src/test/resources").exists());
	}

	@Test
	public void shouldCreateWebXml() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists web.xml.", new File(projectName
				+ "/src/main/webapp/WEB-INF/web.xml").exists());
	}

	@Test
	public void shouldCreatePomXml() throws Exception {
		Scaffold.main(args);
		assertTrue("Should exists pom.xml.", new File(projectName + "/pom.xml")
				.exists());
	}

	@Test
	public void shouldCreateIndex() throws Exception {

		System.out.println(getFileContents("src/main/resources/scaffold/ProductController.java"));
		int n = 10;
		// System.out.printf("I bought %d %s.", n, pluralOf("loaf", n));
		Scaffold.main(args);
		assertTrue("Should exists index.jsp.", new File(projectName
				+ "/src/main/webapp/index.jsp").exists());
	}

	public static String getFileContents(String filename) throws IOException {
		int len = 0;
		char[] buffer = new char[512];
		StringBuilder builder = new StringBuilder();
		FileReader reader = new FileReader(filename);
		BufferedReader buffReader = new BufferedReader(reader);
		try {
			while (((len = buffReader.read(buffer, 0, buffer.length)) != -1)) {
				builder.append(buffer, 0, len);
			}
		} finally {
			buffReader.close();
		}
		return builder.toString();
	}
	
	@Test
	public void testname() throws Exception {
		Scaffold.model();
	}

}