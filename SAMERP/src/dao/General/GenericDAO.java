package dao.General;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.*;

import dao.dbconnect.DBConnection;

public class GenericDAO
{
	protected Connection connection = null ;
	protected boolean    autoCommit = false ;
	private int colCount=0;
	
	/**
	 * generic command to execute any type of sql query than return only scalar result
	 * execute only DDL type queries
	 * @param query to execute
	 */
	public GenericDAO() {
		this(true);
	}
	public GenericDAO(boolean autoCommit) 
	{
		this.autoCommit = autoCommit ;
		
	}
	
	public List getDataList(String query)
	{	
		
		if (autoCommit) initConnection();
		List list = new ArrayList();
		try
		{
			Statement stmt=connection.createStatement();
            ResultSet rs=stmt.executeQuery(query);
            ResultSetMetaData rsmd = rs.getMetaData();
            colCount = rsmd.getColumnCount() ;
            while(rs.next())
			{
            	for(int i = 0 ; i < rsmd.getColumnCount() ; i++)
            	{
            		int colType = rsmd.getColumnType(i+1);
            		switch(colType)
            		{
            			case Types.INTEGER:
            				list.add(rs.getInt(i+1));
            				break;
            			case Types.FLOAT:
            				list.add(rs.getFloat(i+1));
            				break;
            			case Types.DOUBLE:
            				list.add(rs.getDouble(i+1));
            				break;
            			case Types.DATE:
            			case Types.TIMESTAMP:
            				list.add(rs.getDate(i+1));
            				break;
            			case Types.VARCHAR:					//// fall through
            				//list.add(rs.getString(i+1));
            				//break;
            			default:
            				String s= rs.getString(i+1) ;
            			//	System.out.println("-----default Case [string] ---" + colType + " >> " + s);
            				list.add(s);
            				break;
            		}
            		
            	}
			}
		}	
		catch (Exception e)
		{
			System.out.println("[ERROR] getData failed " + new java.util.Date());
			e.printStackTrace(); 
		}finally {if( autoCommit ) endConnection();
					}
		return list ;
	}
	
	
	public int deleteData(String query)
	{
		//for disable foreign key and delete relational data forcefully
		
		if (autoCommit) initConnection();
		int count=0;
		try
		  {
				Statement stmt=connection.createStatement();
				boolean result=stmt.execute("set global foreign_key_checks = 0");
				if(result)
				{
					count=stmt.executeUpdate(query);
					stmt.execute("set global foreign_key_checks = 1");
				}
					
		  }	catch (Exception e)
		   {
				System.out.println("[ERROR] executeCommand failed " + new java.util.Date()); 
				e.printStackTrace() ; 
		   }finally {  if( autoCommit ) endConnection();
		}
        return count;
	}
	
	
	public int executeCommand(String query)
	{
		if (autoCommit) initConnection();
		int count=0;
		try
		  {
				Statement stmt=connection.createStatement();
				count=stmt.executeUpdate(query);	
		  }	catch (Exception e)
		   {
				System.out.println("[ERROR] executeCommand failed " + new java.util.Date()); 
				e.printStackTrace() ; 
		   }finally {  if( autoCommit ) endConnection();
		}
        return count;
	}

	/**
	 * generic method to get data from db of any number of columns
	 * @param query to execute
	 * @return List of data
	 */
	@SuppressWarnings("unchecked")
	
	
	
	public List getData(String query)
	{	
		
		if (autoCommit) initConnection();
		List list = new ArrayList();
		try
		{
			Statement stmt=connection.createStatement();
            ResultSet rs=stmt.executeQuery(query);
            ResultSetMetaData rsmd = rs.getMetaData();
            colCount = rsmd.getColumnCount() ;
            while(rs.next())
			{
            	for(int i = 0 ; i < rsmd.getColumnCount() ; i++)
            	{
            		int colType = rsmd.getColumnType(i+1);
            		switch(colType)
            		{
            			case Types.INTEGER:
            				list.add(rs.getInt(i+1));
            				break;
            			case Types.FLOAT:
            				list.add(rs.getFloat(i+1));
            				break;
            			case Types.DOUBLE:
            				list.add(rs.getDouble(i+1));
            				break;
            			case Types.DATE:
            			case Types.TIMESTAMP:
            				list.add(rs.getDate(i+1));
            				break;
            			case Types.VARCHAR:					//// fall through
            				//list.add(rs.getString(i+1));
            				//break;
            			default:
            				String s= rs.getString(i+1) ;
            			//	System.out.println("-----default Case [string] ---" + colType + " >> " + s);
            				list.add(s);
            				break;
            		}
            		
            	}
			}
		}	
		catch (Exception e)
		{
			System.out.println("[ERROR] getData failed " + new java.util.Date());
			e.printStackTrace(); 
		}finally {if( autoCommit ) endConnection();
					}
		return list ;
	}
	
	public Object getScalar( String quey ) {
		List l = getData(quey) ;
		return l.isEmpty() ? null : l.get(0) ;
	}
	
	public int getColumnCount() { return colCount ; }  ;
	
	protected boolean initConnection( )
	{		
		connection = new DBConnection().getConnection();
		return connection != null;
	}
	protected void endConnection( )
	{
		try
		{
			connection.close();
		}
		catch(SQLException e)
		{
		}
	}
	public void startTransaction( ) {
		initConnection() ;
		try {
			connection.setAutoCommit(autoCommit) ; 
		}catch(Exception e) { e.printStackTrace() ; } 
	}
	public void commit() {
		try {
			connection.commit() ;
		}catch(Exception e) { e.printStackTrace(); }
		endConnection() ; 
	}
	public void rollback() {
		try {
			connection.rollback() ; 
		}catch(Exception e) { e.printStackTrace(); }
		endConnection() ; 
	}
	
	public ResultSet getDataRs(String query)
	{	
		ResultSet rs=null;
		if (autoCommit) initConnection();
		try
		{
			Statement stmt=connection.createStatement();
            rs=stmt.executeQuery(query);
        
		}	
		
		catch (Exception e)
		{
			System.out.println("[ERROR] getData failed " + new java.util.Date());
			e.printStackTrace(); 
		}
		
		return rs ;
	}
	
}