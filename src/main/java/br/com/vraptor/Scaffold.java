package br.com.vraptor;

import static br.com.vraptor.Generator.copy;
import static br.com.vraptor.Generator.generateController;
import static br.com.vraptor.Generator.generateModel;
import static br.com.vraptor.Generator.generatePom;
import static br.com.vraptor.Generator.generateViews;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public final class Scaffold {

	public static void main(String[] args) throws Exception {
		if (args.length == 1) {
			String projectName = args[0];
			
			Generator.create(projectName);
			
			String mainJava = projectName + Generator.buildDirectoryName("src", "main", "java");
			String mainResources = projectName + Generator.buildDirectoryName("src", "main", "resources");
			
			String testJava = projectName + Generator.buildDirectoryName("src", "test", "java");
			String testResources = projectName + Generator.buildDirectoryName("src", "test", "resources");
			
			String webapp = projectName + Generator.buildDirectoryName("src", "main", "webapp");
			
			String appPath = mainJava.concat(File.separator).concat("app");
			
			Generator.create(mainJava);
			Generator.create(mainResources);
			Generator.create(testJava);
			Generator.create(testResources);
			Generator.create(webapp);
			Generator.create(appPath);
			
			Generator.create(appPath + Generator.buildDirectoryName("models"));
			Generator.create(appPath + Generator.buildDirectoryName("controllers"));
			Generator.create(appPath + Generator.buildDirectoryName("infrastructure"));
			
			Generator.create(mainResources + Generator.buildDirectoryName("META-INF"));
			Generator.create(webapp + Generator.buildDirectoryName("decorators"));
			String webInf = webapp + Generator.buildDirectoryName("WEB-INF");
			Generator.create(webInf);
			Generator.create(webInf + Generator.buildDirectoryName("freemarker"));
			
			generatePom(projectName);
			copy("/scaffold/FreemarkerPathResolver.java", projectName + "/src/main/java/app/infrastructure/FreemarkerPathResolver.java");
			copy("/scaffold/index.jsp", projectName + "/src/main/webapp/index.jsp");
			copy("/scaffold/WEB-INF/web.xml", projectName + "/src/main/webapp/WEB-INF/web.xml");
			copy("/scaffold/WEB-INF/decorators.xml", projectName + "/src/main/webapp/WEB-INF/decorators.xml");
			copy("/scaffold/decorators/main.ftl", projectName + "/src/main/webapp/decorators/main.ftl");
			copy("/scaffold/log4j.xml", projectName + "/src/main/resources/log4j.xml");
			copy("/scaffold/META-INF/persistence.xml", projectName + "/src/main/resources/META-INF/persistence.xml");
		}

		if (args.length > 1) {
			String model = args[1];
			List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
			for(int i = 2; i < args.length; i++) {
				String[] attribute = args[i].split(":");
				attributes.add(new AttributeWrapper(attribute[0], attribute[1]));
			}
			generateModel(model, attributes);
			generateController(model);
			generateViews(model, attributes);
		}
	}
}