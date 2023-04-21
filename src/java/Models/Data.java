/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import Controllers.CourseController;
import java.sql.*;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class Data {

    public SortedMap<String, Object[]> StudentList = null;
    public SortedMap<Integer, SortedMap<String,Object[]>> CourseList = null;
    public SortedMap<Integer, SortedMap<String,SortedMap<String,Float>>> StudentInCourse = null;

    private static Data instance;

    private Data() {
        //System.load("src/java/lib/mssql-jdbc_auth-12.2.0.x64.dll");
        Model model = new Model();
        
        //Student List
        try {
            StudentList = new TreeMap<>();
            model.getStudentList(StudentList);
        } catch (SQLException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //Course List
        try {
            CourseList = new TreeMap<>();
            model.getCourseList(CourseList);
        } catch (SQLException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }

        //Course List
        try {
            StudentInCourse = new TreeMap<>();
            model.getStudentInCourseList(StudentInCourse);
        } catch (SQLException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    public static synchronized Data getInstance() {
        if (instance == null) {
            instance = new Data();
        }
        return instance;
        
    }
    
}
