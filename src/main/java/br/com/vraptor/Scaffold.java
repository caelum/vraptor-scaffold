package br.com.vraptor;

import static br.com.vraptor.FileUtils.buildDirectoryName;
import static br.com.vraptor.FileUtils.create;
import static br.com.vraptor.FileUtils.writeFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jvnet.inflector.Noun;

import freemarker.template.TemplateException;
import freemarker.template.utility.StringUtil;

public class Scaffold {
	
	private String model;
	private Map<String, Object> content;
	
	public Scaffold(String model, List<AttributeWrapper> attributes) {
		this.model = model.toLowerCase();
		
		content = new HashMap<String, Object>();
		content.put("attributes", attributes);
		content.put("model", model);
		content.put("modelPlural", Noun.pluralOf(model));
		content.put("path", "/" + Noun.pluralOf(model));
	}
	
	public void generateModel() throws IOException, TemplateException {
		String directory = "src" + buildDirectoryName("main", "java", "app", "models");
		new File(directory).exists();
		
		String filename = directory + buildDirectoryName(StringUtil.capitalize(model) + ".java");
		
		templateToFile("TemplateModel.ftl", filename);
	}

	public void generateController() throws IOException, TemplateException {
		String directory = "src" + buildDirectoryName("main", "java", "app", "controllers");
		String filename = directory + buildDirectoryName(StringUtil.capitalize(model) + "Controller.java");
		
		templateToFile("TemplateController.ftl", filename);
	} 
	
	public void generateViews() throws IOException, TemplateException {
		String viewDirectory = "src" + buildDirectoryName("main", "webapp", "WEB-INF", "freemarker") +  buildDirectoryName(model);
		create(viewDirectory);
		templateToFile("views/edit.ftl", viewDirectory  + buildDirectoryName("edit.ftl"));
		templateToFile("views/index.ftl", viewDirectory  + buildDirectoryName("index.ftl"));
		templateToFile("views/new.ftl", viewDirectory  + buildDirectoryName ("new" + StringUtil.capitalize(model) + ".ftl"));
		templateToFile("views/show.ftl", viewDirectory  + buildDirectoryName("show.ftl"));
	}
	
	private void templateToFile(String template, String filename) throws IOException, TemplateException {
		writeFile(TemplateHandler.getInstance().loadTemplate(template), content, filename);
	}
}