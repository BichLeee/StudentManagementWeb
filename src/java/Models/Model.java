/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.*;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class Model {

    //
    String url = "jdbc:sqlserver://PANDA\\SQLEXPRESS01:1433;databaseName=JAVA_CoursesDB;"
            + "trustServerCertificate=true";
    String username = "sa";
    String password = "1";

    public Model() {
    }

    public void getStudentList(SortedMap<String, Object[]> StudentList) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Student");
            while (rs.next()) {
                String id = rs.getString("id");
                Object[] info = new Object[]{
                    rs.getString("name"),
                    rs.getString("grade"),
                    rs.getString("dob"),
                    rs.getString("address"),
                    rs.getString("notes")
                };
                StudentList.put(id, info);
            }
            closeConnection(conn, stmt);
            //destroyDriver();
        } catch (SQLException | ClassNotFoundException ex) {
            closeConnection(conn, stmt);
            //destroyDriver();
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }
    }

    public void getCourseList(SortedMap<Integer, SortedMap<String,Object[]>> CourseList) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Course");
            while (rs.next()) {
                String id = rs.getString("id");
                String year_str = rs.getString("_year");
                Object[] info = new Object[]{
                    rs.getString("name"),
                    rs.getString("lecture"),
                    rs.getString("notes")
                };
                int year = Integer.parseInt(year_str);
                if(CourseList.get(year)==null){
                    //SortedMap<String,Object[]> temp = new TreeMap<>();
                    CourseList.put(year, new TreeMap<>());
                }
                CourseList.get(year).put(id, info);
            }
            closeConnection(conn, stmt);
            //destroyDriver();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            closeConnection(conn, stmt);
            //destroyDriver();
            return;
        }
    }
    
    public void getStudentInCourseList(SortedMap<Integer, SortedMap<String,SortedMap<String,Float>>> list) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM student_regist_course");
            while (rs.next()) {
                String course_id = rs.getString("course_id");
                String year_str = rs.getString("_year");
                String student_id = rs.getString("student_id");
                String grade = rs.getString("grade");
                int year = Integer.parseInt(year_str);
                if(list.get(year)==null){
                    list.put(year, new TreeMap<>());
                }
                    if(list.get(year).get(course_id)==null){
                    list.get(year).put(course_id, new TreeMap<>());
                }
                list.get(year).get(course_id).put(student_id, Float.parseFloat(grade));
            }
            closeConnection(conn, stmt);
            //destroyDriver();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            closeConnection(conn, stmt);
            //destroyDriver();
            return;
        }
    }

    public boolean executeUpdate(String query) {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            var rs = stmt.executeUpdate(query);
            closeConnection(conn, stmt);
            return rs!=0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            closeConnection(conn, stmt);
            return false;
            //destroyDriver();
        }
    }
    
    

    public void closeConnection(Connection conn, Statement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
                System.out.println("Statement closed");
            }
            if (conn != null) {
                conn.close();
                System.out.println("Connection closed");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void destroyDriver() {
        //destroy driver
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        try {
            while (drivers.hasMoreElements()) {
                Driver driver = drivers.nextElement();
                //if (driver.getClass().getClassLoader() == getClass().getClassLoader()) {
                DriverManager.deregisterDriver(driver);
                //}
            }
        } catch (SQLException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
