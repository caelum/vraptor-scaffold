package br.com.vraptor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public final class Scaffold {
	
	private static final String MAIN_PATH = "/src/main/";
	private static final String SRC_PATH = MAIN_PATH + "java";
	private static final String RESOURCE_PATH = MAIN_PATH + "resource";
	private static final String WEBAPP_PATH = MAIN_PATH + "webapp";
	
	public static void main(String[] args) throws IOException {
		for (String arg: args) {
			new File(arg).mkdir();
			new File(arg + SRC_PATH).mkdirs();
			new File(arg + RESOURCE_PATH).mkdir();
			new File(arg + WEBAPP_PATH + "/WEB-INF").mkdirs();
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
}