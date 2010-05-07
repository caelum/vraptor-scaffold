package br.com.vraptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;

import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.utility.StringUtil;

public final class Scaffold {

	private static final String MAIN_PATH = "/src/main/";
	private static final String TEST_PATH = "/src/test/";
	private static final String WEBAPP_PATH = MAIN_PATH + "webapp";

	public static void main(String[] args) throws Exception {
		for (String arg : args) {
			if (args.length == 1) {
				new File(arg + MAIN_PATH + "java").mkdirs();
				new File(arg + TEST_PATH + "java").mkdirs();
				new File(arg + MAIN_PATH + "resources").mkdir();
				new File(arg + TEST_PATH + "resources").mkdir();
				new File(arg + WEBAPP_PATH + "/WEB-INF").mkdirs();
				generatePom(arg);
				copy("/scaffold/index.jsp", arg + "/src/main/webapp/index.jsp");
				copy("/scaffold/web.xml", arg
						+ "/src/main/webapp/WEB-INF/web.xml");
			}
		}
		
		if (args.length > 1) {
			String model = args[1];
			List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
			for(int i = 2; i < args.length; i++) {
				String[] attribute_string = args[i].split(":");
				attributes.add(new AttributeWrapper(attribute_string[0], attribute_string[1]));
			}
			generateModel(model, attributes);
		}
	}

	private static void copy(String src, String dst) throws IOException {
		InputStream in = Scaffold.class.getResourceAsStream(src);
		OutputStream out = new FileOutputStream(new File(dst));
		IOUtils.copy(in, out);
	}

	private static void generatePom(String arg) throws IOException, TemplateException {
		Template pom = loadTemplate("pom.xml");
		
		Map<String, String> content = new HashMap<String, String>();
		content.put("GROUP_ID", arg);
		content.put("ARTIFACT_ID", arg);
		content.put("NAME", arg);
		
		writeFile(pom, content, arg + "/pom.xml");
	}

	private static void writeFile(Template template, Map<String, ?> content, String filename)
			throws IOException, TemplateException {
		File file = new File(filename);
		Writer output = new BufferedWriter(new FileWriter(file));
		try {
			template.process(content, output);
			output.flush();
		} finally {
			output.close();
		}
	}

	public static Template loadTemplate(String name) throws IOException, TemplateException {
		Configuration cfg = new Configuration();
		cfg.setObjectWrapper(ObjectWrapper.DEFAULT_WRAPPER);
		cfg.setClassForTemplateLoading(Scaffold.class, "/scaffold");

		return cfg.getTemplate(name);
	}
	
	private static void generateModel(String model, List<AttributeWrapper> attributes) throws IOException, TemplateException {
		Template templateModel = loadTemplate("TemplateModel.ftl");
		Map<String, Object> content = new HashMap<String, Object>();
		content.put("class", model);
		content.put("attributes", attributes);
		new File("src/main/java/app/models/").mkdirs();
		String filename = "src/main/java/app/models/" + StringUtil.capitalize(model) + ".java";
		writeFile(templateModel, content, filename);
	}
	
	
}