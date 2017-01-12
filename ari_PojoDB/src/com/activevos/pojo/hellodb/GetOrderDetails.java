package com.activevos.pojo.hellodb;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GetOrderDetails implements IGetOrderDetails {

	public String getOrderDetails(OrderDetailsParam param) {
		// TODO Auto-generated method stub
		String xml = "";
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/ariDB"); // name as mentioned the datasource config
			Connection conn = (Connection) ds.getConnection();
			Statement stmt = conn.createStatement() ;

		      // Execute the query to retrieve the details from line_items
		      ResultSet rs = stmt.executeQuery( 
		    		  "SELECT * " +
		    		  "FROM line_items where purchase_order_id=\"" + 
		    		  Integer.toString(param.getPurchaseOrderId()) + "\"" ) ;

		      xml = 
					"<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
					"<PurReqDetail xmlns=\"http://www.solazyme.com/PurchaseRequest\"" + 
					 " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">";

		      while( rs.next() ) {

				 xml +=  "<PRQLineItems>" +
			        "<LineItemID>"+ Integer.toString(rs.getInt("line_item_id")) + "</LineItemID>" +
			        "<PurRequestID>"+ Integer.toString(rs.getInt("purchase_req_id")) + "</PurRequestID>" +
			        "<PurOrderID>"+ Integer.toString(rs.getInt("purchase_order_id")) + "</PurOrderID>" +
			        "<LineProductNum>"+ rs.getString("product_num") +"</LineProductNum>" +
			        "<Quantity>"+ Float.toString(rs.getFloat("quantity")) + "</Quantity>" +
			        "<ItemCost>"+ Float.toString(rs.getFloat("item_cost")) + "</ItemCost>" +
			        "<TotalCost>"+ Float.toString(rs.getFloat("total_cost")) + "</TotalCost>" +
			        "<Description>"+ rs.getString("description") + "</Description>" +
			    "</PRQLineItems>";
		         System.out.println(xml);		         
		      };
		      xml += "</PurReqDetail>";
		      System.out.println(xml);		         
		      // Close the result set, statement and the connection
		      rs.close() ;
		      stmt.close() ;
		      conn.close();
			
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		};
		return xml;
	}
}
