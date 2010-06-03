package br.com.vraptor;

import static br.com.vraptor.FileUtils.buildDirectoryName;
import static br.com.vraptor.FileUtils.copy;
import static br.com.vraptor.FileUtils.create;
import static br.com.vraptor.FileUtils.writeFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Template;
import freemarker.template.TemplateException;

public class BlankProject {
	
	private String project;
	
	public BlankProject(String project) {
		this.project = project;
	}
	
	public void createProject() throws IOException {
		create(project);
	}
	
	public void createMainJava() throws IOException {
		String mainJava = project + buildDirectoryName("src", "main", "java");
		String appPath = mainJava + buildDirectoryName("app");
		String infrastructure = appPath + buildDirectoryName("infrastructure");
		create(mainJava);
		create(appPath);
		create(appPath + buildDirectoryName("models"));
		create(appPath + buildDirectoryName("controllers"));
		create(infrastructure);
		copy("/scaffold/FreemarkerPathResolver.java", infrastructure + buildDirectoryName("FreemarkerPathResolver.java"));
	}
	
	public void createMainResources() throws IOException {
		String mainResources = project + buildDirectoryName("src", "main", "resources");
		String metaInf = mainResources + buildDirectoryName("META-INF");
		create(mainResources);
		copy("/scaffold/log4j.xml", mainResources + buildDirectoryName("log4j.xml"));
		create(metaInf);
		copy("/scaffold/META-INF/persistence.xml", metaInf + buildDirectoryName("persistence.xml"));
	}
	
	public void createWebApp() throws IOException {
		String webapp = project + buildDirectoryName("src", "main", "webapp");
		String webInf = webapp + buildDirectoryName("WEB-INF");
		String decorators = webapp + buildDirectoryName("decorators");
		
		create(webapp);
		copy("/scaffold/index.jsp", webapp + buildDirectoryName("index.jsp"));
		
		create(webInf);
		copy("/scaffold/WEB-INF/decorators.xml", webInf + buildDirectoryName("decorators.xml"));
		copy("/scaffold/WEB-INF/web.xml",  webInf + buildDirectoryName("web.xml"));
		create(webInf + buildDirectoryName("freemarker"));
		create(decorators);
		
		copy("/scaffold/decorators/main.ftl", decorators + buildDirectoryName("main.ftl"));
	}
	
	public void createTestJava() {
		create(project + buildDirectoryName("src", "test", "java"));
	}
	
	public void createTestResources() {
		create(project + buildDirectoryName("src", "test", "resources"));
	}
	
	public void createPom() throws IOException, TemplateException {
		String pom = "pom.xml";
		Template template = TemplateHandler.getInstance().loadTemplate(pom);
		
		Map<String, String> content = new HashMap<String, String>();
		content.put("GROUP_ID", project);
		content.put("ARTIFACT_ID", project);
		content.put("NAME", project);

		writeFile(template, content, project + buildDirectoryName(pom));
	}
}