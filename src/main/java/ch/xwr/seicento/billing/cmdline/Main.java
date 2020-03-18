package ch.xwr.seicento.billing.cmdline;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import ch.xwr.seicento.billing.db.BaseSetup;
import ch.xwr.seicento.billing.flyway.FlywayApp;
import ch.xwr.seicento.billing.model.Params;

public class Main {
	private static Params param = null;

	public static void main(String[] args) {
		param = new Params();
		loadParams(System.getenv("CONFIG_FILE"));
		
		System.out.println("-------------------------------------------------");
		System.out.println("Start check Database...");
		BaseSetup setup = new BaseSetup();
		setup.checkDb(param);
		System.out.println("-------------------------------------------------");
		System.out.println("");
		
		
		System.out.println("Start flyway - check tables...");
		FlywayApp flw = new FlywayApp(param);
		flw.startup();
		
		System.out.println("");
		System.out.println("[END]");
		System.out.println("");
	}

	private static void loadParams(String cfgfile) {
		if (cfgfile != null) {
			File fi = new File(cfgfile);
			if (fi.exists()) {
				System.out.println("Read configuration from File " + cfgfile);
				setParamFromFile(fi);
				return;
			}			
		}
		
	    param.setDbtype(getDefValueString(System.getenv("DB_TYPE"), param.getDbtype()));
		param.setDbhost(getDefValueString(System.getenv("DB_HOST"), param.getDbhost()));
	    param.setDbname(getDefValueString(System.getenv("DB_NAME"), param.getDbname()));
	    param.setLoadDemoData(Boolean.parseBoolean(getDefValueString(System.getenv("LOAD_SAMPLE_DATA"), "" + param.isLoadDemoData())));
	    param.setPassword(getDefValueString(System.getenv("DB_PASSWORD"), param.getPassword()));
	    param.setUser(getDefValueString(System.getenv("DB_USER"), param.getUser()));
	    param.setPort(Integer.parseInt(getDefValueString(System.getenv("DB_PORT"), "" + param.getPort())));		
	    param.setFlaywayRepair(Boolean.parseBoolean(getDefValueString(System.getenv("FLYWAY_REPAIR").trim(), "" + param.isFlaywayRepair())));
	}

	private static String getDefValueString(String getenv, String defaultValue) {
		if (getenv != null && !getenv.isEmpty()) {
			return getenv;
		}
		
		return defaultValue;
	}

	private static void setParamFromFile(File fi) {	
		Properties prop = new Properties();
		try {
			InputStream inp = new FileInputStream(fi);
		    prop.load(inp);

		    param.setDbtype(prop.getProperty("dbtype".trim(), param.getDbtype()));
		    param.setDbhost(prop.getProperty("dbhost".trim(), param.getDbhost()));
		    param.setDbname(prop.getProperty("dbname".trim(), param.getDbname()));
		    param.setLoadDemoData(Boolean.getBoolean(prop.getProperty("loadDemoData".trim(), "" + param.isLoadDemoData())));
		    param.setPassword(prop.getProperty("password".trim(), param.getPassword()));
		    param.setUser(prop.getProperty("user".trim(), param.getUser()));
		    param.setPort(Integer.parseInt(prop.getProperty("port".trim(), "" + param.getPort())));
		    param.setFlaywayRepair(Boolean.parseBoolean(prop.getProperty("flyway.dorepair".trim(), "" + param.isFlaywayRepair())));
		    
		} catch (IOException ex) {
		    ex.printStackTrace();
		} catch (Exception ei) {
			System.out.println("Error while reading config file!");
			ei.printStackTrace();
		}
	}

}
