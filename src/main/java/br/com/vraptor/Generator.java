package br.com.vraptor;

import java.util.ArrayList;
import java.util.List;

public final class Generator {
	
	public static void main(String[] args) throws Exception {
			String model = args[1];
			
			List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
			for(int i = 2; i < args.length; i++) {
				String[] attribute = args[i].split(":");
				attributes.add(new AttributeWrapper(attribute[0], attribute[1]));
			}
			
			Scaffold scaffold = new Scaffold(model, attributes);
			scaffold.generateController();
			scaffold.generateModel();
			scaffold.generateViews();
	}
}
