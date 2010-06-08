package br.com.vraptor;

import java.util.ArrayList;
import java.util.List;

public final class Generator {
	
	public static void main(String[] args) throws Exception {
		if (args.length == 1) {
			String projectName = args[0];
			
			BlankProject project = new BlankProject(projectName);
			project.createProject();
			project.createPom();
			project.createMainJava();
			project.createMainResources();
			project.createWebApp();
			project.createTestJava();
			project.createTestResources();
		}

		if (args.length > 1) {
			String model = args[1];
			
			List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
			for(int i = 2; i < args.length; i++) {
				String[] attribute = args[i].split(":");
				attributes.add(new AttributeWrapper(attribute[0], attribute[1]));
			}
			
			Scaffold scaffold = new Scaffold(model, attributes);
			scaffold.generateModel();
			scaffold.generateController();
			scaffold.generateViews();
		}
	}
}