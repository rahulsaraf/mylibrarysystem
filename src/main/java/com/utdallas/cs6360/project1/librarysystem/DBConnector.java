/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @author Rahul
 *
 */
public class DBConnector {

	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplateObject;
	   
	   public void setDataSource(DataSource dataSource) {
	      this.dataSource = dataSource;
	      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
	   }

	public JdbcTemplate getJdbcTemplateObject() {
		return jdbcTemplateObject;
	}
	
	
}
