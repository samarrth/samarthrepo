package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.UUID;

public class Connection_Provider {
	public static Connection getCon()
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=rootj2ee");
			Statement stmt = con.createStatement();
			return con;
		}catch(Exception e)
		{
			System.out.println(e);
			return null;
		}
		
	}
	public static String generateTransactionId() {
		// Get current timestamp
		long timestamp = System.currentTimeMillis();

		// Generate a random UUID
		String uuid = UUID.randomUUID().toString();

		// Combine elements to create a unique transaction ID
		String transactionId = timestamp + "_" + uuid;

		// You can further format or manipulate the transaction ID as needed
		return transactionId;
	}
}
