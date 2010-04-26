package br.com.vraptor.test;

import java.io.File;

import org.junit.Ignore;

@Ignore
public class TestHelper {
	
	public static boolean deleteFile(String path) {
		File file = new File(path);
		if (file.isDirectory()) {
			File[] childFiles = file.listFiles();
			for (File child : childFiles) {
				deleteFile(child.getAbsolutePath());
			}
		}
		return file.delete();
	}
}