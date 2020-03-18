package ch.xwr.seicento.billing.db;

import ch.xwr.seicento.billing.model.Params;

public class JdbcHelper {
	private String driver = "";
	private String dburl = "";
	private String dburl2 = "";
	private Params param = null;
	
	public JdbcHelper(Params param) {
		this.param = param;
		
		if (param.getDbtype().toLowerCase().equals("postgresql")) {
			setupPostgres(param);						
		} else {
			setupMssql(param);			
		}		
		
	}
	
	private void setupPostgres(Params param) {
		driver = "org.postgresql.Driver";		
		dburl = "jdbc:postgresql://" + param.getDbhost() + ":" + param.getPort() + "/";				
		dburl2 = dburl + param.getDbname();
	}

	private void setupMssql(Params param) {
		driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		dburl = "jdbc:sqlserver://" + param.getDbhost() + ":" + param.getPort();
		dburl2 = dburl + ";databaseName=" + param.getDbname();
	}

	public Params getParam() {
		return param;
	}
	
	public String getDburlWithName() {
		return dburl2;
	}
	
	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getDburl() {
		return dburl;
	}

	public void setDburl(String dburl) {
		this.dburl = dburl;
	}
	
	
}
