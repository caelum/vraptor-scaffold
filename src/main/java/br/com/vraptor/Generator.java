package br.com.vraptor;

import java.util.ArrayList;
import java.util.List;

public class Generator {
	
	public static void main(String[] args) throws Exception {
		if (args.length == 1) {
			String project = args[0];
			Scaffold scaffold = new Scaffold(project);
			scaffold.createProject();
			scaffold.createPom();
			scaffold.createMainJava();
			scaffold.createMainResources();
			scaffold.createWebApp();
			scaffold.createTestJava();
			scaffold.createTestResources();
		}

		if (args.length > 1) {
			String model = args[1];
			Scaffold scaffold = new Scaffold(model);
			
			List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
			for(int i = 2; i < args.length; i++) {
				String[] attribute = args[i].split(":");
				attributes.add(new AttributeWrapper(attribute[0], attribute[1]));
			}
			scaffold.setAttributes(attributes);
			scaffold.generateModel();
			scaffold.generateController();
			scaffold.generateViews();
		}
	}
}
