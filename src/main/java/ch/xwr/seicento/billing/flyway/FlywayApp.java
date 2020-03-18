package ch.xwr.seicento.billing.flyway;

import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationInfo;

import ch.xwr.seicento.billing.db.JdbcHelper;
import ch.xwr.seicento.billing.model.Params;

public class FlywayApp {

	private JdbcHelper hlp;
	private Params param;

	public FlywayApp(Params param) {
		this.param = param;
		hlp = new JdbcHelper(param);
	}


	public void startup() {
		String url = hlp.getDburlWithName();
		System.out.println(url);
		
        // Create the Flyway instance and point it to the database
        Flyway flyway = Flyway.configure().dataSource(url, hlp.getParam().getUser(), hlp.getParam().getPassword()).load();
        //flyway.co
        if (hlp.getParam().getDbtype().equals("postgresql")) {
        	Flyway.configure().schemas("dbo");
        	//Flyway.configure().locations("classpath:db/postgresql/sql");
        	
            flyway.setLocations("classpath:db/postgresql/sql");
            flyway.setSchemas("dbo");
        } else {
        	//Flyway.configure().locations("classpath:db/mssql/sql");
            flyway.setLocations("classpath:db/mssql/sql");        	
        }
        
        if (param.isFlaywayRepair()) {
        	flyway.repair();
        }
        
        // Start the migration
        flyway.migrate();
        
        //info
        MigrationInfo[] arr = flyway.info().all();
        System.out.println("");        
        System.out.println("+------------+---------+------------------------+----------+---------------------+----------------+");
    	System.out.println("| Category   | Version | Description            | Type     | Installed On        | State          |");
        System.out.println("+------------+---------+------------------------+----------+---------------------+----------------+");
        
        for (int i = 0; i < arr.length; i++) {
        	System.out.println(getFormatInfoLine(arr[i]));
		}
        
        //flyway.clean();
        //flyway.repair();
	}


	private String getFormatInfoLine(MigrationInfo migl) {
		StringBuilder apr = new StringBuilder();
		apr.append("|            ");
		if (migl.getVersion() != null) {
			apr.append(getField(migl.getVersion().getVersion(), 10));			
		} else {
			apr.append(getField("R", 10));
		}
		apr.append(getField(migl.getDescription(), 25));
		apr.append(getField(migl.getType().toString(), 11));
		apr.append(getField(migl.getInstalledOn().toString(), 22));
		apr.append(getField(migl.getState().toString(), 17)).append("|");

		return apr.toString();
	}


	private String getField(String value, int len) {
		String space = "                           ";
		String retVal = "| " + value + space;
		return retVal.substring(0, len);
	}
}
