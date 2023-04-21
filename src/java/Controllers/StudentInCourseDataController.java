/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.Data;
import Models.Model;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.TreeMap;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/SICData"})

public class StudentInCourseDataController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("load_student_table".equals(action)) {
            String year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            String course_id = req.getParameter("course_id");

            //Lấy dữ liệu
            var list_course = Data.getInstance().StudentInCourse.get(year);
            String content = "";
            if (list_course != null) {
                var list_student = list_course.get(course_id);
                if (list_student != null) {
                    var student_info = Data.getInstance().StudentList;
                    for (var student_id : list_student.keySet()) {
                        String student_name = (String) student_info.get(student_id)[0];
                        System.out.println(student_name);
                        content += (student_id + "," + student_name + "," + list_student.get(student_id).toString() + "~");
                    }
                }
            }

            //gửi respone
            PrintWriter out = res.getWriter();
            out.print(content);
            out.flush();
        } else if ("load_student_grade_table".equals(action)) {
            String year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            String student_id = req.getParameter("student_id");
            //Lấy dữ liệuf
            var list_course = Data.getInstance().StudentInCourse.get(year);
            String content = "";
            if (list_course != null) {
                var course_info = Data.getInstance().CourseList.get(year);
                for (var course : list_course.keySet()) {
                    var grade = list_course.get(course).get(student_id);
                    if (grade != null) {
                        var course_name = (String) course_info.get(course)[0];
                        content += (student_id + "," + course_name + "," + grade.toString() + "~");

                    }
                }
            }

            //gửi respone
            PrintWriter out = res.getWriter();
            out.print(content);
            out.flush();
        } else if ("add_student".equals(action)) {
            String year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            String course_id = req.getParameter("course_id");
            String student_id = req.getParameter("student_id");
            String grade = req.getParameter("grade");
            System.err.println(course_id + year + student_id + grade);

            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "INSERT INTO student_regist_course VALUES (\'" + student_id + "\',\'" + course_id + "\'," + year_str + ","
                    + grade + ")"
            );
            if (rs == true) {
                var list = Data.getInstance().StudentInCourse;
                if (list.get(year) == null) {
                    list.put(year, new TreeMap<>());
                }
                if (list.get(year).get(course_id) == null) {
                    list.get(year).put(course_id, new TreeMap<>());
                }
                list.get(year).get(course_id).put(student_id, Float.parseFloat(grade));
            } else {
            }

        } else if ("remove_student".equals(action)) {
            String year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            String course_id = req.getParameter("course_id");
            String student_id = req.getParameter("student_id");

            Model model = new Model();
            boolean rs = model.executeUpdate(
                    "DELETE FROM student_regist_course WHERE student_id=\'" + student_id
                    + "\' AND course_id=\'" + course_id + "\' AND _year=" + year
            );
            if (rs == true) {
                Data.getInstance().StudentInCourse.get(year).get(course_id).remove(student_id);
            } else {
            }
        }
    }

}
