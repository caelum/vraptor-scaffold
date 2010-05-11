package br.com.vraptor;

import static br.com.vraptor.Generator.copy;
import static br.com.vraptor.Generator.generateModel;
import static br.com.vraptor.Generator.generatePom;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public final class Scaffold {

	private static final String MAIN_PATH = "/src/main/";
	private static final String TEST_PATH = "/src/test/";
	private static final String WEBAPP_PATH = MAIN_PATH + "webapp";


	public static void main(String[] args) throws Exception {
		if (args.length == 1) {
			String projectName = args[0];
			new File(projectName + MAIN_PATH + "java/app/models").mkdirs();
			new File(projectName + MAIN_PATH + "java/app/controllers").mkdir();
			new File(projectName + TEST_PATH + "java").mkdirs();
			new File(projectName + MAIN_PATH + "resources").mkdir();
			new File(projectName + TEST_PATH + "resources").mkdir();
			new File(projectName + WEBAPP_PATH + "/WEB-INF/").mkdirs();
			new File(projectName + WEBAPP_PATH + "/decorators").mkdir();
			generatePom(projectName);
			copy("/scaffold/index.jsp", projectName + "/src/main/webapp/index.jsp");
			copy("/scaffold/WEB-INF/web.xml", projectName + "/src/main/webapp/WEB-INF/web.xml");
			copy("/scaffold/WEB-INF/decorators.xml", projectName + "/src/main/webapp/WEB-INF/decorators.xml");
			copy("/scaffold/decorators/main.ftl", projectName + "/src/main/webapp/decorators/main.ftl");
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
}