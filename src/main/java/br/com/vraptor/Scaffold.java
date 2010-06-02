package br.com.vraptor;

import static br.com.vraptor.FileUtils.writeFile;
import static br.com.vraptor.FileUtils.create;
import static br.com.vraptor.FileUtils.buildDirectoryName;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jvnet.inflector.Noun;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.utility.StringUtil;

public class Scaffold {
	
	private String model;
	private List<AttributeWrapper> attributes;
	
	public Scaffold(String model, List<AttributeWrapper> attributes) {
		this.model = model.toLowerCase();
		this.attributes = attributes;
	}
	
	public void generateModel() throws IOException, TemplateException {
		Template templateModel = TemplateHandler.getInstance().loadTemplate("TemplateModel.ftl");
		Map<String, Object> content = new HashMap<String, Object>();
		content.put("model", model);
		content.put("attributes", attributes);
		String filename = "src/main/java/app/models/" + StringUtil.capitalize(model) + ".java";

		new File("src/main/java/app/models").mkdirs();
		writeFile(templateModel, content, filename);
	}

	public void generateController() throws IOException, TemplateException {
		Template templateModel = TemplateHandler.getInstance().loadTemplate("TemplateController.ftl");
		Map<String, String> content = new HashMap<String, String>();
		content.put("model", model);
		content.put("path", "/" + Noun.pluralOf(model));
		String filename = "src/main/java/app/controllers/" + StringUtil.capitalize(model) + "Controller.java";
		
		new File("src/main/java/app/controllers").mkdirs();
		writeFile(templateModel, content, filename);
	} 
	
	public void generateViews() throws IOException, TemplateException {
		Template indexTemplate = TemplateHandler.getInstance().loadTemplate("view/index.ftl");
		Template newTemplate = TemplateHandler.getInstance().loadTemplate("view/new.ftl");
		
		Map<String, Object> content = new HashMap<String, Object>();
		content.put("attributes", attributes);
		content.put("model", model);
		content.put("modelPlural", Noun.pluralOf(model));
		
		String viewDirectory = Path.VIEW_DIRECTORY +  buildDirectoryName(model);
		
		create(viewDirectory);
		
		writeFile(indexTemplate, content, viewDirectory  + "/index.ftl");
		writeFile(newTemplate, content, viewDirectory  + "/new" + StringUtil.capitalize(model) + ".ftl");
	}
}