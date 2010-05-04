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
import java.util.Map;

import org.apache.commons.io.IOUtils;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public final class Scaffold {

	private static final String MAIN_PATH = "/src/main/";
	private static final String TEST_PATH = "/src/test/";
	private static final String WEBAPP_PATH = MAIN_PATH + "webapp";

	public static void main(String[] args) throws Exception {
		for (String arg : args) {
			new File(arg + MAIN_PATH + "java").mkdirs();
			new File(arg + TEST_PATH + "java").mkdirs();
			new File(arg + MAIN_PATH + "resources").mkdir();
			new File(arg + TEST_PATH + "resources").mkdir();
			new File(arg + WEBAPP_PATH + "/WEB-INF").mkdirs();
			generatePom(arg);
			copy("/scaffold/index.jsp", arg + "/src/main/webapp/index.jsp");
			copy("/scaffold/web.xml", arg + "/src/main/webapp/WEB-INF/web.xml");
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

	private static void writeFile(Template template, Map<String, String> content, String filename)
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
		cfg.setObjectWrapper(new DefaultObjectWrapper());
		cfg.setClassForTemplateLoading(Scaffold.class, "/scaffold");

		return cfg.getTemplate(name);
	}
}