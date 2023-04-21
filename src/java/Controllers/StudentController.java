/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Models.Data;
import Models.Model;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/Student"})
public class StudentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/StudentList.jsp");
        dispatcher.forward(req, res);
        //res.sendRedirect("Views/StudentList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String action = req.getParameter("action");
        System.out.println(action);
        if ("add".equals(action)) {
            String id = req.getParameter("id");
            String[] info = {
                req.getParameter("name"),
                req.getParameter("grade"),
                req.getParameter("dob"),
                req.getParameter("address"),
                req.getParameter("notes"),};
            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "INSERT INTO Student VALUES (\'" + id + "\',N\'" + info[0] + "\'," + info[1] + ",\'"
                    + info[2] + "\',N\'" + info[3] + "\',N\'" + info[4] + "\')");
            if (rs == true) {
                Data.getInstance().StudentList.put(id, info);
            } else {
            }

        } else if ("delete".equals(action)) {
            String id = req.getParameter("id");
            System.out.println(id);

            Model model = new Model();
            model.executeUpdate(
                    "DELETE FROM student_regist_course WHERE student_id=\'" + id+"\'"
            );
            boolean rs = model.executeUpdate(
                    "DELETE FROM Student WHERE id=\'" + id+"\'"
            );
            if (rs == true) {
                Data.getInstance().StudentList.remove(id);
            } else {
            }
        } else if ("edit".equals(action)) {
            String id = req.getParameter("id");
            String[] info = {
                req.getParameter("name"),
                req.getParameter("grade"),
                req.getParameter("dob"),
                req.getParameter("address"),
                req.getParameter("notes"),};
            
            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "UPDATE Student "+
                            "SET name = N\'"+ info[0] + "\' ," +
                            "grade = "+ info[1] + " ," + 
                            "address = N\'"+ info[2] + "\' ," + 
                            "notes = N\'"+ info[2] + "\' " + 
                            "WHERE id = "+ id);
                   
            if (rs == true) {
                Data.getInstance().StudentList.put(id, info);
            } else {
            }
        } 

        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/StudentList.jsp");
        dispatcher.forward(req, res);
    }
}
