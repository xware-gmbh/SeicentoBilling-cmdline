package ch.xwr.seicento.billing.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import ch.xwr.seicento.billing.model.Params;

public class BaseSetup {
	JdbcHelper hlp = null;
	// JDBC driver name and database URL
	//static final String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.Driver";
	//static final String DB_URL = "jdbc:mysql://localhost/";

	// Database credentials
	public void checkDb(Params param) {
		hlp = new JdbcHelper(param);
		
		if (!existDatabase(param)) {
			createDb(param);
		} else {
			System.out.println("Database does already exist.");
		}		
	}
	
	private boolean existDatabase(Params param) {
		Connection con = null;
		ResultSet rs = null;

		try{

			Class.forName(hlp.getDriver());
			con = DriverManager.getConnection(hlp.getDburl(), param.getUser(), param.getPassword());			
			String dbName = param.getDbname();

			if(con != null){				
				System.out.println("check if a database exists with name " + param.getDbname());
				System.out.println(hlp.getDburl());

				if (param.getDbtype().equalsIgnoreCase("postgresql")) {
					//Postgres
					String SQL = "SELECT count(*) FROM pg_catalog.pg_database WHERE lower(datname) = lower('" + param.getDbname() + "')"; 
	                Statement stmt = con.createStatement();
	                rs = stmt.executeQuery(SQL);
	                rs.next();
	                int icount = rs.getInt(1);
	                
	                if (icount > 0) return true;
				} else {
					//MSSql
					rs = con.getMetaData().getCatalogs();

					while(rs.next()){
						String catalogs = rs.getString(1);
						
						if(dbName.equalsIgnoreCase(catalogs)){
							System.out.println("the database "+dbName+" exists");
							return true;
						}
					}					
				}
								
				System.out.println("Database does not exist!");
			}
			else{
				System.out.println("unable to create database connection");
			}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		finally{
			if( rs != null){
				try{
				    rs.close();
				}
				catch(SQLException ex){
					ex.printStackTrace();
				}
			}
			if( con != null){
				try{
				    con.close();
				}
				catch(SQLException ex){
					ex.printStackTrace();
				}
			}
		}
		return false;
	}	
	
	
	private void createDb(Params param) {				
		Connection conn = null;
		Statement stmt = null;
		try {
			// STEP 2: Register JDBC driver
			//Class.forName("com.mysql.jdbc.Driver");
			Class.forName(hlp.getDriver());
			
			// STEP 3: Open a connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(hlp.getDburl(), param.getUser(), param.getPassword());

			// STEP 4: Execute a query
			System.out.println("Creating database...");
			stmt = conn.createStatement();

			String sql = "CREATE DATABASE " + param.getDbname();
			stmt.executeUpdate(sql);
			System.out.println("Database created successfully...");
		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			// finally block used to close resources
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			} // nothing we can do
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			} // end finally try
		} // end try
		System.out.println("Goodbye!");
	}

	
}
