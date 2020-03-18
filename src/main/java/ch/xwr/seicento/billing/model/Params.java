package ch.xwr.seicento.billing.model;

public class Params {
	private String user = "dbsa";
	private String password = "dbsa100%";
	private String dbname = "TestNameX";
	private String dbtype = "mssql";   //postgresql, mssql
	private String dbhost = "localhost";
	private int port = 1433;
	private boolean loadDemoData = false;
	private boolean flaywayRepair = false;
	
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDbname() {
		return dbname;
	}
	public void setDbname(String dbname) {
		if (getDbtype().equalsIgnoreCase("postgresql")) {
			dbname = dbname.toLowerCase();
		}
		
		this.dbname = dbname;
	}
	public String getDbtype() {
		return dbtype;
	}
	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}
	public String getDbhost() {
		return dbhost;
	}
	public void setDbhost(String dbhost) {
		this.dbhost = dbhost;
	}
	public boolean isLoadDemoData() {
		return loadDemoData;
	}
	public void setLoadDemoData(boolean loadDemoData) {
		this.loadDemoData = loadDemoData;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public boolean isFlaywayRepair() {
		return flaywayRepair;
	}
	public void setFlaywayRepair(boolean flaywayRepair) {
		this.flaywayRepair = flaywayRepair;
	}
	
	
	
}
