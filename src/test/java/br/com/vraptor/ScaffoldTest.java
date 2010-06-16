package br.com.vraptor;

import static br.com.vraptor.FileUtils.buildDirectoryName;
import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * Tests to {@link Scaffold}.
 */
public class ScaffoldTest {

	private Scaffold scaffold;
	private String model = "product";
	
	@Before
	public void before() {
		List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
		attributes.add(new AttributeWrapper("name", "string"));
		attributes.add(new AttributeWrapper("value", "double"));
		scaffold = new Scaffold(model, attributes);
	}

	@After
	public void after() throws IOException {
		FileUtils.deleteDirectory(new File("src/main/java/app"));
	}

	@Test
	public void shouldGenerateModel() throws Exception {
		String directory = "src" + buildDirectoryName("main", "java", "app", "models");
		new File(directory).mkdirs();
		
		scaffold.generateModel();
		File model = new File(directory + "/Product.java" );
		assertTrue("Should exists model to product.", model.exists());
	}
	
	@Test
	public void shouldGenerateController() throws Exception {
		String directory = "src" + buildDirectoryName("main", "java", "app", "controllers");
		new File(directory).mkdirs();
		scaffold.generateController();
		
		File controller = new File(directory + "/ProductController.java");
		assertTrue("Should exists controller to product.", controller.exists());
	}
	
	@Test
	public void shouldGenerateView() throws Exception {
		String directory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		new File(directory).mkdirs();
		scaffold.generateViews();
		
		File controller = new File(directory + "/newProduct.ftl");
		assertTrue("Should exists view to create.", controller.exists());
	}
	
	@Test
	public void shouldGenerateViewToCreate() throws Exception {
		String directory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		new File(directory).mkdirs();
		scaffold.generateViews();
		
		File view = new File(directory + "/newProduct.ftl");
		assertTrue("Should exists view.", view.exists());
	}
	
	@Test
	public void shouldGenerateViewToEdit() throws Exception {
		String directory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		new File(directory).mkdirs();
		scaffold.generateViews();
		
		File view = new File(directory + "/edit.ftl");
		assertTrue("Should exists view.", view.exists());
	}
	
	@Test
	public void shouldGenerateViewToList() throws Exception {
		String directory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		new File(directory).mkdirs();
		scaffold.generateViews();
		
		File view = new File(directory + "/index.ftl");
		assertTrue("Should exists view.", view.exists());
	}
	
	@Test
	public void shouldGenerateViewToShow() throws Exception {
		String directory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		new File(directory).mkdirs();
		scaffold.generateViews();
		
		File view = new File(directory + "/show.ftl");
		assertTrue("Should exists view.", view.exists());
	}
}