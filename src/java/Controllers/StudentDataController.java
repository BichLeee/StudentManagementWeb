/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.Data;
import com.sun.net.httpserver.HttpsServer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.console;
import java.util.SortedMap;
import java.util.TreeMap;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/StudentData"})

public class StudentDataController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            String id = req.getParameter("id");

            // Thiết lập các header cho response
            res.setContentType("text/plain");
            res.setCharacterEncoding("UTF-8");

            //Lấy dữu liệu
            Object[] info = Data.getInstance().StudentList.get(id);
            String content = info[0].toString();
            for (int i = 1; i < info.length; i++) {

                content += ("," + info[i]);
                System.out.println(content);
            }
            //gửi respone
            PrintWriter out = res.getWriter();
            out.print(content);
            out.flush();
        } else if ("search".equals(action)) {
            String name = req.getParameter("name");
            System.out.println(name);
            var data = Data.getInstance().StudentList;
            String rs = "";
            if (data != null) {
                for (String id : data.keySet()) {
                    if (data.get(id)[0].toString().toLowerCase().contains(name.toLowerCase()) == true) {
                        var info = data.get(id);
                        rs += (id + "," + info[0] + "," + info[1] + "," + info[2] + "," + info[3] + "," + info[4] + "~");
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
