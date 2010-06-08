package br.com.vraptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Writer;
import java.util.Map;

import org.apache.commons.io.IOUtils;

import freemarker.template.Template;
import freemarker.template.TemplateException;

public final class FileUtils {

	public static void copy(String src, String dst) throws IOException {
		InputStream in = FileUtils.class.getResourceAsStream(src);
		OutputStream out = new FileOutputStream(new File(dst));
		IOUtils.copy(in, out);
		System.out.println("Created: " + dst);
	}

	public static void writeFile(Template template, Map<String, ?> content, String filename) throws IOException, TemplateException {
		File file = new File(filename);
		Writer output = new BufferedWriter(new FileWriter(file));
		try {
			template.process(content, output);
			output.flush();
		} finally {
			output.close();
		}
		System.out.println("Created: " + filename);
	}
	
	public static String buildDirectoryName(String... pathFragments) {
		String path = "";
		for (String fragment : pathFragments) {
			path = path.concat(File.separator + fragment);
		}
		return path;
	}
	
	public static void create(String path) {
		new File(path).mkdirs();
		System.out.println("Created: " + path);
	}
}