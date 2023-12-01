package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.Board;
import board.BoardDAO;
import member.Member;
import member.MemberDAO;
import reply.Reply;
import reply.ReplyDAO;

@WebServlet("*.do")	// "/" 이하의 경로에서 do로 끝나는 확장자는 모두 허용
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 10L;
	MemberDAO mDAO;
	BoardDAO bDAO;
	ReplyDAO rDAO;
       
    public MainController() {	//생성자
        mDAO = new MemberDAO();
        bDAO = new BoardDAO();
        rDAO = new ReplyDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글 인코딩
		request.setCharacterEncoding("utf-8");
		//응답할 컨텐츠 유형
		response.setContentType("text/html; charset=utf-8");
		
		//경로 설정
		//uri = 컨텍스트(/) + 파일(.do)
		String uri = request.getRequestURI();
		System.out.println(uri);
		//커맨드 패턴
		String command = uri.substring(uri.lastIndexOf("/"));
		System.out.println(command);
		
		String nextPage = "";
		
		//세션 객체 생성
		HttpSession session = request.getSession();
		//view에 출력 객체 생성
		PrintWriter out = response.getWriter();

		if(command.equals("/memberlist.do")) {
			//회원 정보를 db에서 가져옴
			List<Member> memberList = mDAO.getMemberList();
			//모델 생성
			request.setAttribute("memberList", memberList);
			//이동할 페이지
			nextPage = "/member/memberlist.jsp";
		}else if(command.equals("/joinform.do")) {
			nextPage = "/member/joinform.jsp";
		}else if(command.equals("/insertmember.do")) {
			//빈 회원 객체를 생성해서 데이터를 받아서 세팅
			//폼 데이터 받기
			String id = request.getParameter("id");
			String passwd = request.getParameter("passwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			
			Member m = new Member();
			//db에 저장
			m.setId(id);
			m.setPasswd(passwd);
			m.setName(name);
			m.setEmail(email);
			m.setGender(gender);
			
			mDAO.insertMember(m);
			nextPage = "/index.jsp";
		}else if(command.equals("/memberview.do")) {
			String id = request.getParameter("id");
			Member member = mDAO.getMember(id);
			//모델 생성
			request.setAttribute("member", member);
			nextPage = "/member/memberview.jsp";
		}else if(command.equals("/loginform.do")){	//로그인 폼 페이지 이동
			nextPage = "/member/loginform.jsp";
		}else if(command.equals("/login.do")) {	//로그인 처리
			//아이디와 비밀번호 파라미터 받기
			String id = request.getParameter("id");
			String passwd = request.getParameter("passwd");
			
			//빈 객체를 생성해서 아이디와 비번 세팅해줌
			Member m = new Member();
			m.setId(id);
			m.setPasswd(passwd);
			
			//로그인 인증
			boolean result = mDAO.checkLogin(m);
			if(result){
				session.setAttribute("sessionId", id);
				//로그인 후 페이지 이동
				//nextPage = "/index.jsp";			
				out.println("<script>");
				out.println("alert('로그인 되었습니다.')");
				out.println("location.href='../index.jsp'");
				out.println("</script>");
				out.flush();
				out.close();
			}else{
				//에러 알림창 띄움(자바 스크립트)
				/*out.println("<script>");
				out.println("alert('아이디나 비밀번호를 확인해주세요.')");
				out.println("history.back()");	//이전 페이지로 이동
				out.println("</script>");*/
				
				//에러를 모델로 보내기
				String error = "아이디나 비밀번호를 다시 확인해주세요.";
				request.setAttribute("error", error);
				//에러 발생 후 페이지 이동
				nextPage="/member/loginform.do";
			}
			
		}else if(command.equals("/logout.do")) {
			session.invalidate();	//모든 세션 삭제
			//nextPage = "/index.jsp";

			out.println("<script>");
			out.println("alert('로그아웃 되었습니다.')");
			out.println("location.href='../index.jsp'");
			out.println("</script>");
			out.flush();
			out.close();
		}
		
		//게시판
		if(command.equals("/boardlist.do")) {
			//db에서 list를 가져옴
			List<Board> boardList = bDAO.getBoardList();
			//모델 생성
			request.setAttribute("boardList", boardList);
			nextPage="/board/boardlist.jsp";
		}else if(command.equals("/writeform.do")) {
			nextPage="/board/writeform.jsp";
		}else if(command.equals("/write.do")) {
			//폼 데이터 받기
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String id = (String) session.getAttribute("sessionId");
			
			//db에 저장
			Board b = new Board();
			b.setTitle(title);
			b.setContent(content);
			b.setId(id);
			
			bDAO.write(b);
					
		}else if(command.equals("/boardview.do")){
			//글 제목에서 요청한 글 번호 받기
			int bno = Integer.parseInt(request.getParameter("bno"));
			
			//글 상세보기 처리
			Board board = bDAO.getBoard(bno);
			
			//댓글 목록 보기
			List<Reply> replyList = rDAO.getReplyList(bno);
			
			//모델 생성해서 뷰로 보내기
			request.setAttribute("board", board);
			request.setAttribute("replyList", replyList);
			
			nextPage="/board/boardview.jsp";
		}else if(command.equals("/deleteboard.do")) {
			int bno = Integer.parseInt(request.getParameter("bno"));
			
			bDAO.deleteboard(bno);
			
			nextPage="/boardlist.do";
		}else if(command.equals("/updateboardform.do")) {
			int bno = Integer.parseInt(request.getParameter("bno"));
			
			//글 상세보기 처리
			Board board = bDAO.getBoard(bno);
			
			//모델 생성해서 뷰로 보내기
			request.setAttribute("board", board);
			
			
			nextPage="/board/updateboardform.jsp";
		}else if(command.equals("/updateboard.do")) {
			//게시글 제목, 내용을 파라미터로 받음
			int bno = Integer.parseInt(request.getParameter("bno"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
				
			//db에 저장
			Board b = new Board();
			b.setTitle(title);
			b.setContent(content);
			b.setBno(bno);
			
			bDAO.updateboard(b);
			
			
			//nextPage="/boardlist.do";
		}
		
		//댓글 구현
		if(command.equals("/insertreply.do")) {
			//댓글 폼 데이터 받기
			int bno = Integer.parseInt(request.getParameter("bno"));
			String rcontent = request.getParameter("rcontent");
			String replyer = request.getParameter("replyer");
			
			//댓글 등록 처리
			Reply r = new Reply();
			r.setBno(bno);
			r.setRcontent(rcontent);
			r.setReplyer(replyer);
			
			rDAO.insertreply(r);
			
		}
		if(command.equals("/deletereply.do")) {
			int rno = Integer.parseInt(request.getParameter("rno"));
			//삭제 처리 메서드 호출
			rDAO.deletereply(rno);		
		}

		//redirect와 forward 구분하기
		//새로고침하면 게시글, 댓글 중복 생성 문제 해결
		if(command.equals("/write.do") || command.equals("/updateboard.do")) { 
			response.sendRedirect("boardlist.do");
		} else if (command.equals("/insertreply.do") || command.equals("/deletereply.do")) {
			int bno = Integer.parseInt(request.getParameter("bno"));
			response.sendRedirect("boardview.do?bno=" + bno);
		}else{
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}
		


	}
	
}
