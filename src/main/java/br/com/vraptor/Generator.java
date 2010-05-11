package br.com.vraptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;

import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.utility.StringUtil;

public class Generator {

	private static Configuration CFG = new Configuration();

	static {
		CFG = new Configuration();
		CFG.setObjectWrapper(ObjectWrapper.DEFAULT_WRAPPER);
		CFG.setClassForTemplateLoading(Scaffold.class, "/scaffold");
	}

	public static void copy(String src, String dst) throws IOException {
		InputStream in = Scaffold.class.getResourceAsStream(src);
		OutputStream out = new FileOutputStream(new File(dst));
		IOUtils.copy(in, out);
	}

	public static void generateModel(String model, List<AttributeWrapper> attributes) throws IOException, TemplateException {
		Template templateModel = CFG.getTemplate("TemplateModel.ftl");
		Map<String, Object> content = new HashMap<String, Object>();
		content.put("class", model);
		content.put("attributes", attributes);
		String filename = "src/main/java/app/models/" + StringUtil.capitalize(model) + ".java";

		new File("src/main/java/app/models").mkdirs();
		writeFile(templateModel, content, filename);
	}

	public static void generateController(String model) throws IOException, TemplateException {
		Template templateModel = CFG.getTemplate("TemplateController.ftl");
		Map<String, String> content = new HashMap<String, String>();
		content.put("class", model);
		String filename = "src/main/java/app/controllers/" + StringUtil.capitalize(model) + "Controller.java";

		new File("src/main/java/app/controllers").mkdirs();
		writeFile(templateModel, content, filename);
	}

	public static void generatePom(String projectName) throws IOException, TemplateException {
		Template pom = CFG.getTemplate("pom.xml");
		Map<String, String> content = new HashMap<String, String>();
		content.put("GROUP_ID", projectName);
		content.put("ARTIFACT_ID", projectName);
		content.put("NAME", projectName);

		writeFile(pom, content, projectName + "/pom.xml");
	}

	private static void writeFile(Template template, Map<String, ?> content, String filename) throws IOException, TemplateException {
		File file = new File(filename);
		Writer output = new BufferedWriter(new FileWriter(file));
		try {
			template.process(content, output);
			output.flush();
		} finally {
			output.close();
		}
	}
}