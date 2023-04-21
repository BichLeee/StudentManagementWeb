/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.Data;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/CourseData"})

public class CourseDataController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("loadtable".equals(action)) {
            var year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            System.out.println(year);
            var data = Data.getInstance().CourseList.get(year);
            String rs = "";
            if (data != null) {
                for (String id : data.keySet()) {
                    var info = data.get(id);
                    rs += (id + "," + info[0] + "," + info[1] + "," + info[2] + "~");
                }
            }

            System.out.println(rs);
            PrintWriter out = res.getWriter();
            out.print(rs);
            out.flush();
        } else if ("edit_getID".equals(action)) {
            var year_str = req.getParameter("year");
            int year = Integer.parseInt(year_str);
            var data = Data.getInstance().CourseList.get(year);
            String rs = "";
            if (data != null) {
                for (var id : data.keySet()) {
                    rs = rs + (id + ",");
                }
            }
            //gửi respone
            PrintWriter out = res.getWriter();
            out.print(rs);
            out.flush();

        } else if ("edit_getInfo".equals(action)) {
            String year = req.getParameter("year");
            String id = req.getParameter("id");

            // Thiết lập các header cho response
            res.setContentType("text/plain");
            res.setCharacterEncoding("UTF-8");

            //Lấy dữu liệu
            var data = Data.getInstance().CourseList.get(Integer.valueOf(year));
            String content = "";
            if (data != null) {
                Object[] info = data.get(id);
                content = info[0].toString();
                for (int i = 1; i < info.length; i++) {
                    content += ("," + info[i]);
                }
            }
            //gửi respone
            PrintWriter out = res.getWriter();
            out.print(content);
            out.flush();
        } else if ("search".equals(action)) {
            String year_str = req.getParameter("year");
            String name = req.getParameter("name");
            System.out.println(name);
            var data = Data.getInstance().CourseList.get(Integer.valueOf(year_str));
            String rs = "";
            if (data != null) {
                for (String id : data.keySet()) {
                    if (data.get(id)[0].toString().toLowerCase().contains(name.toLowerCase()) == true) {
                        var info = data.get(id);
                        rs += (id + "," + info[0] + "," + info[1] + "," + info[2] + "~");
                    }
                }
            }
            System.out.println(rs);
            PrintWriter out = res.getWriter();
            out.print(rs);
            out.flush();
        }

    }
}
