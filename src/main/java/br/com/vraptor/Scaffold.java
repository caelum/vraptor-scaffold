package br.com.vraptor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public final class Scaffold {
	
	private static final String MAIN_PATH = "/src/main/";
	private static final String TEST_PATH = "/src/test/";
	private static final String WEBAPP_PATH = MAIN_PATH + "webapp";
	
	public static void main(String[] args) throws IOException {
		for (String arg: args) {
			new File(arg + MAIN_PATH + "java").mkdirs();
			new File(arg + TEST_PATH + "java").mkdirs();
			new File(arg + MAIN_PATH + "resources").mkdir();
			new File(arg + TEST_PATH + "resources").mkdir();
			new File(arg + WEBAPP_PATH + "/WEB-INF").mkdirs();
			copy("/scaffold/pom.xml", arg + "/pom.xml");
			copy("/scaffold/index.jsp", arg + "/src/main/webapp/index.jsp");
			copy("/scaffold/web.xml", arg + "/src/main/webapp/WEB-INF/web.xml");
		}
	}
	
	private static void copy(String src, String dst) throws IOException {
	    InputStream in = Scaffold.class.getResourceAsStream(src);
	    OutputStream out = new FileOutputStream(new File(dst));

	    // Transfer bytes from in to out
	    byte[] buf = new byte[1024];
	    int len;
	    while ((len = in.read(buf)) > 0) {
	        out.write(buf, 0, len);
	    }
	    in.close();
	    out.close();
	}
	
	public static void model() throws IOException, TemplateException {
		 /* ------------------------------------------------------------------- */    
        /* You should do this ONLY ONCE in the whole application life-cycle:   */    
    
        /* Create and adjust the configuration */
        Configuration cfg = new Configuration();
        cfg.setObjectWrapper(ObjectWrapper.DEFAULT_WRAPPER);
        cfg.setClassForTemplateLoading(Scaffold.class, "/");
        /* ------------------------------------------------------------------- */    
        /* You usually do these for many times in the application life-cycle:  */    
                
        /* Get or create a template */
        Template temp = cfg.getTemplate("/scaffold/TemplateModel.ftl");

        /* Create a data-model */
        Map root = new HashMap();
        List<AttributeWrapper> attributes = new ArrayList<AttributeWrapper>();
        
        AttributeWrapper attributeWrapper2 = new AttributeWrapper();
		AttributeWrapper attributeWrapper = new AttributeWrapper();
		
        attributeWrapper.setName("name");
        attributeWrapper.setType("string");
        
        attributeWrapper2.setName("value");
        attributeWrapper2.setType("Long");
        
		attributes.add(attributeWrapper);
        attributes.add(attributeWrapper2);
		
		root.put("attributes", attributes);
		root.put("package", "${package}");
        
        /* Merge data-model with template */
        Writer out = new OutputStreamWriter(new FileOutputStream(new File("/home/rodolfo/Desktop/Model.java")));
        temp.process(root, out);
        out.flush();
	}
}