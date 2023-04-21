/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.Data;
import Models.Model;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/", "/Course"})
public class CourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/CourseList.jsp");
        dispatcher.forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String action = req.getParameter("action");
        System.out.println(action);
        if ("add".equals(action)) {
            int year = Integer.parseInt((req.getParameter("year")));
            String id = req.getParameter("id");
            String[] info = {
                req.getParameter("name"),
                req.getParameter("lecture"),
                req.getParameter("notes")};
            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "INSERT INTO Course VALUES (\'" + id + "\',N\'" + info[0] + "\',N\'" + info[1] + "\',"
                    + year + ",N\'" + info[2] + "\')");
            if (rs == true) {
                Data.getInstance().CourseList.get(year).put(id, info);
            } else {
            }

        } else if ("delete".equals(action)) {
            String id = req.getParameter("id");
            String year = req.getParameter("year");
            System.out.println(id);

            Model model = new Model();
            model.executeUpdate(
                    "DELETE FROM student_regist_course WHERE course_id=\'" + id + "\'"
            );
            boolean rs = model.executeUpdate(
                    "DELETE FROM Course WHERE id=\'" + id + "\' AND _year=" + year
            );
            if (rs == true) {
                Data.getInstance().CourseList.get(Integer.parseInt(year)).remove(id);
            } else {
            }
        } else if ("edit".equals(action)) {
            String id = req.getParameter("id");
            String year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            String[] info = {
                req.getParameter("name"),
                req.getParameter("lecture"),
                req.getParameter("notes")};

            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "UPDATE Course "
                    + "SET name = N\'" + info[0] + "\' ,"
                    + "lecture = N\'" + info[1] + "\' ,"
                    + "notes = N\'" + info[2] + "\' "
                    + "WHERE id = \'" + id + "\' AND _year = " + year_str);

            if (rs == true) {

                Data.getInstance().CourseList.get(year).put(id, info);
            } else {
            }
        }

//        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/CourseList.jsp");
//        dispatcher.forward(req, res);
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/CourseList.jsp");
        dispatcher.forward(req, res);
    }
}
