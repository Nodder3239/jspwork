package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.Board;
import board.BoardDAO;


@WebServlet("*.jsp")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       BoardDAO bDAO;
       
    public BoardController() {
        bDAO = new BoardDAO();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String uri = request.getRequestURI();
		System.out.println(uri);
		String command = uri.substring(uri.lastIndexOf("/"));
		System.out.println(command);
		
		String nextPage = "";
		
		PrintWriter out = response.getWriter();
		
		if(command.equals("/boardlist.jsp")) {
			
			List<Board> boards = bDAO.getBoardList();
			request.setAttribute("boards", boards);
			nextPage = "/board/boardlist.jsp";
		}
	}

}
