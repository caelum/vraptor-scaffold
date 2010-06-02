package br.com.vraptor;

public enum Path {
	
	SRC_MAIN_JAVA(FileUtils.buildDirectoryName("src", "main", "java")), 
	SRC_MAIN_WEBAPP(SRC_MAIN_JAVA + FileUtils.buildDirectoryName("webapp")), 
	VIEW_DIRECTORY(SRC_MAIN_WEBAPP + FileUtils.buildDirectoryName("WEB-INF", "freemarker"));
	
	private String path;
	
	private Path(String path) {
		this.path = path;
	}
	
	@Override
	public String toString() {
		return path;
	}
}