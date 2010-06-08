package br.com.vraptor;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Test;

/**
 * Tests to {@link Generator}.
 */
public class GeneratorTest {
	
	private String projectName = "vraptor-scaffold";
	
	@After
	public void after() throws IOException {
		FileUtils.deleteDirectory(new File(projectName));
	}
	
	@Test
	public void shouldGenerateProject() throws Exception {
		String[] args = {projectName};
		Generator.main(args);
		
		assertTrue("Should exists project folder.", new File(projectName).exists());
	}
}
