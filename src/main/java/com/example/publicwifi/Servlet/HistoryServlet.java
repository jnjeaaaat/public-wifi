package com.example.publicwifi.Servlet;

import com.example.publicwifi.Service.WifiService;
import com.example.publicwifi.model.History;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private WifiService wifiService = new WifiService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<History> histories = wifiService.getHistoryList();

        request.setAttribute("histories", histories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("history.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int historyId = Integer.parseInt(request.getParameter("historyId"));
        System.out.println(historyId);
        wifiService.deleteHistory(historyId);

        response.sendRedirect("history.jsp");
//        RequestDispatcher dispatcher = request.getRequestDispatcher("history.jsp");
//        dispatcher.forward(request, response);
    }
}
