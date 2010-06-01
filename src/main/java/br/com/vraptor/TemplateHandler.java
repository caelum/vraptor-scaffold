package br.com.vraptor;

import java.io.IOException;

import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;

public class TemplateHandler {
	
	private static final Configuration CFG = new Configuration();
	private static TemplateHandler templateHandler;
	
	static {
		CFG.setObjectWrapper(ObjectWrapper.DEFAULT_WRAPPER);
		CFG.setClassForTemplateLoading(TemplateHandler.class, "/scaffold");
	}
	
	private TemplateHandler() {
	}
	
	public static TemplateHandler getInstance() {
		if (templateHandler == null) {
			templateHandler = new TemplateHandler();
		}
		return templateHandler;
	}
	
	public Template loadTemplate(String template) throws IOException {
		return CFG.getTemplate(template);
	}
}