package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import blike.Blike;
import blike.BlikeDAO;
import board.Board;
import board.BoardDAO;
import member.Member;
import member.MemberDAO;
import reply.Reply;
import reply.ReplyDAO;
import voter.Voter;
import voter.VoterDAO;

@WebServlet("*.do")	// "/" 이하의 경로에서 do로 끝나는 확장자는 모두 허용
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 10L;
	MemberDAO mDAO;
	BoardDAO bDAO;
	ReplyDAO rDAO;
	BlikeDAO lDAO;
	VoterDAO vDAO;
       
    public MainController() {	//생성자
        mDAO = new MemberDAO();
        bDAO = new BoardDAO();
        rDAO = new ReplyDAO();
        lDAO = new BlikeDAO();
        vDAO = new VoterDAO();
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
		

		if(command.equals("/main.do")){ //http://localhost:8080/
			//메인 페이지에 게시글 보내기
			List<Board> boardList = bDAO.getBoardList();
			request.setAttribute("boardList", boardList);			
			
			if(boardList.size()>=3) {
				//게시글 3개를 저장할 배열 생성
				Board[] newBoards = {boardList.get(0), boardList.get(1), boardList.get(2)};
				
				request.setAttribute("boardList", newBoards);
			}
			
			//메인 페이지에 게시글 보내기
			List<Board> likeList = bDAO.getLikeList();
			request.setAttribute("likeList", likeList);			
			
			if(likeList.size()>=3) {
				//게시글 3개를 저장할 배열 생성
				Board[] newLikes = {likeList.get(0), likeList.get(1), likeList.get(2)};
				
				request.setAttribute("likeList", newLikes);
			}
			
			
			
			nextPage="/main.jsp";
		}else if(command.equals("/memberlist.do")) {
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
			//db에 저장함
			mDAO.insertMember(m);
			//자동 로그인
			session.setAttribute("sessionId", m.getId());	//아이디를 가져와서 sessionId(세션이름) 발급
			session.setAttribute("sessionName", m.getName());	//이름을 가져와서 sessionName(세션이름) 발급
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
			Member member = mDAO.checkLogin(m);
			String name = member.getName();
			if(name != null){
				session.setAttribute("sessionId", id);//아이디 세션 발급
				session.setAttribute("sessionName", name);//이름 세션 발급
				//로그인 후 페이지 이동
				//nextPage = "/index.jsp";			
				out.println("<script>");
				out.println("alert('로그인 되었습니다.')");
				out.println("location.href='../main.do'");
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
			//페이지 처리
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null) { //페이지 번호를 클릭하지 않았을때 기본값
				pageNum = "1";
			}
			
			//현재 페이지
			int currentPage = Integer.parseInt(pageNum);
			//페이지당 게시글 수 - 10(pageSize)
			int pageSize = 10;
			//1페이지의 첫번째행(startRow) : 1번, 2페이지 : 11번, 3페이지 : 21
			int startRow = (currentPage - 1) * pageSize + 1;
			System.out.println("페이지 첫행: " + startRow);
			
			//시작페이지(startPage) : 12행 - 2페이지, 22행 - 3페이지
			int startPage = startRow / pageSize + 1;
			
			//종료(끝) 페이지 : 전체 게시글총수 / 페이지당 개수
			int totalRow = bDAO.getBoardCount();
			int endPage = totalRow / pageSize;
			//페이지당 개수(10)로 나누어 떨어지지 않는 경우 코딩
			endPage = (totalRow % pageSize == 0) ? endPage : endPage + 1;
			//System.out.println("총 게시글 수: " + totalRow);
			//System.out.println("마지막 페이지: " + endPage);
			
			//검색 처리
			String _field = request.getParameter("field"); //임시로 저장
			String _kw = request.getParameter("kw");
			
			String field = "";
			String kw = "";
			
			//null 처리
			if(_field != null) { //필드값이 있는 경우
				field = _field;
			}else { //필드값이 없는 경우(디폴트)
				field = "title";
			}
			
			if(_kw != null) { //검색어가 있는 경우
				kw = _kw;
			}else {  //검색어가 없는 경우
				kw = "";
			}
		
			//페이지 처리 목록 메서드 호출
			//List<Board> boardList = bDAO.getBoardList(currentPage);
			//검색 처리
			//List<Board> boardList = bDAO.getBoardList(field, kw);
			//페이지와 검색 처리
			List<Board> boardList = bDAO.getBoardList(field, kw, currentPage);
			
			//모델로 생성
			request.setAttribute("boardList", boardList);
			request.setAttribute("page", currentPage);    //현재 페이지
			request.setAttribute("startPage", startPage); //시작 페이지
			request.setAttribute("endPage", endPage);     //종료 페이지
			request.setAttribute("field", field);  //검색어
			request.setAttribute("kw", kw);  //검색어
			
			List<Board> likeList = bDAO.getLikeList();
			request.setAttribute("likeList", likeList);			
			
			if(likeList.size()>=3) {
				//게시글 3개를 저장할 배열 생성
				Board l1 = likeList.get(0);
				Board l2 = likeList.get(1);
				Board l3 = likeList.get(2);
				
				request.setAttribute("l1", l1);
				request.setAttribute("l2", l2);
				request.setAttribute("l3", l3);
			}else if(likeList.size() == 2) {
				Board l1 = likeList.get(0);
				Board l2 = likeList.get(1);

				request.setAttribute("l1", l1);
				request.setAttribute("l2", l2);
			}else if(likeList.size() == 1) {
				Board l1 = likeList.get(0);

				request.setAttribute("l1", l1);
			}
			
			nextPage="/board/boardlist.jsp";
		}else if(command.equals("/writeform.do")) {
			nextPage="/board/writeform.jsp";
		}else if(command.equals("/write.do")) {
			String realFolder = "C:\\jspworks\\members\\src\\main\\webapp\\upload";
			int maxSize = 10*1024*1024; //10MB
			String encType = "utf-8";	//파일 이름 한글 인코딩
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			//5가지 인자
			MultipartRequest multi = 
					new MultipartRequest(request, realFolder, maxSize, 
							encType, policy);
			
			
			//폼 데이터 받기
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			
			//세션 가져오기
			String id = (String) session.getAttribute("sessionId");
			
			//file 파라미터 추출
			Enumeration<?> files = multi.getFileNames();
			String filename = "";
			while(files.hasMoreElements()) {	//파일 이름이 있는 동안 반복
				String userFilename = (String) files.nextElement();
				
				//실제 저장될 이름
				filename = multi.getFilesystemName(userFilename);		
			}
			
			
			
			//db에 저장
			Board b = new Board();
			b.setTitle(title);
			b.setContent(content);
			b.setFilename(filename);
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
			
			// 좋아요 개수 가져오기
			int likeCount = lDAO.getLikeCountByBno(bno);
			//List<Blike> likeList = lDAO.getLikeList(bno);

			// 모델 생성해서 뷰로 보내기
			request.setAttribute("like_count", likeCount);

			//lDAO.updateLikeCount(bno);
			int voteCount = vDAO.voteCount(bno);
			request.setAttribute("voteCount", voteCount);
			
			bDAO.updateReplyCount(bno);
			
			String id = (String) session.getAttribute("sessionId");
			
			//하트의 상태 바꾸기(토글 방식)
			boolean sw = false;
			int result = vDAO.checkVoter(bno, id);	//게시글 번호, 세션 아이디
			if(result == 0) {
				sw = true;
			}else {
				sw = false;
			}
			
			request.setAttribute("sw", sw);
			
			/*
			boolean n = true;
			
			//아이디가 중복되면 delete, 아니면 update
			if (lDAO.likeListContainsUser(likeList, id)) {	
				n = true;
			} else {
			    n = false;
			}	
			
			request.setAttribute("n", n);
			*/
			
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
			/*
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
			*/
			//게시글 제목, 내용을 파라미터로 받음
			
			String realFolder = "C:\\jspworks\\members\\src\\main\\webapp\\upload";
			int maxSize = 10*1024*1024; //10MB
			String encType = "utf-8";	//파일 이름 한글 인코딩
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			//5가지 인자
			MultipartRequest multi = 
					new MultipartRequest(request, realFolder, maxSize, 
							encType, policy);
			
			//폼 데이터 받기
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			int bno = Integer.parseInt(multi.getParameter("bno"));
			
			//file 파라미터 추출
			Enumeration<?> files = multi.getFileNames();
			String filename = "";
			while(files.hasMoreElements()) {	//파일 이름이 있는 동안 반복
				String userFilename = (String) files.nextElement();
				
				//실제 저장될 이름
				filename = multi.getFilesystemName(userFilename);		
			}
				
			//db에 저장
			Board b = new Board();
			b.setTitle(title);
			b.setContent(content);
			b.setFilename(filename);
			b.setBno(bno);
			
			//파일 유무에 따른 처리
			if(filename != null) {	//파일이 있는 경우
				bDAO.updateboard(b);
			}else {				//파일이 없는 경우
				bDAO.updateboardNoFile(b);
			}
			
			
			
			
		//검색 처리	
		}/*else if(command.equals("/search.do")) {
			
			String field = request.getParameter("field");
			String kw = request.getParameter("kw");

			
			List<Board> boardList = bDAO.searchBoards(field, kw);
			
			request.setAttribute("boardList", boardList);
			
			List<Board> likeList = bDAO.getLikeList();
			request.setAttribute("likeList", likeList);			
			
			
			if(likeList.size()>=3) {
				//게시글 3개를 저장할 배열 생성
				Board l1 = likeList.get(0);
				Board l2 = likeList.get(1);
				Board l3 = likeList.get(2);
				
				request.setAttribute("l1", l1);
				request.setAttribute("l2", l2);
				request.setAttribute("l3", l3);
			}
			
			
			nextPage="/board/boardlist.jsp";
		}
		*/
		
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
			
		}else if(command.equals("/updatereplyform.do")) {
			int rno = Integer.parseInt(request.getParameter("rno"));
						
			//글 상세보기 처리
			Reply reply = rDAO.getReply(rno);
			
			//모델 생성해서 뷰로 보내기
			request.setAttribute("reply", reply);
			
			
			nextPage="/board/updatereplyform.jsp";
		}else if(command.equals("/updatereply.do")) {
			int rno = Integer.parseInt(request.getParameter("rno"));
			String rcontent = request.getParameter("rcontent");
			
			Reply r = new Reply();
			r.setRno(rno);
			r.setRcontent(rcontent);
			
			rDAO.updatereply(r);
			
		}
		
		
		if(command.equals("/deletereply.do")) {
			int rno = Integer.parseInt(request.getParameter("rno"));
			//삭제 처리 메서드 호출
			rDAO.deletereply(rno);	
			
			nextPage="/boardlist.do";
		}
		
		//좋아요
		if(command.equals("/like.do")) {
			int bno = Integer.parseInt(request.getParameter("bno"));
			String id = request.getParameter("id");
			
			Voter voter = new Voter();
			voter.setBno(bno);
			voter.setMid(id);
			
			//좋아요 저장 유무 체크
			int result = vDAO.checkVoter(bno, id);
			if(result == 0) {	//db에 없으면(저장 안됨
				vDAO.insertVote(voter);	//좋아요 추가
			}else {	//result == 1
				vDAO.deleteVote(voter);	//좋아요 삭제
			}
			
			
			/*
			int bno = Integer.parseInt(request.getParameter("bno"));
			String id = request.getParameter("id");
			List<Blike> likeList = lDAO.getLikeList(bno);
			
			
			//아이디가 중복되면 delete, 아니면 update
			if (lDAO.likeListContainsUser(likeList, id)) {	
				lDAO.deleteLike(id, bno);	
			} else {
				Blike l = new Blike();
				l.setBno(bno);
				l.setId(id);
			    lDAO.like(l);
			}	
			lDAO.updateLikeCount(bno);
			nextPage="boardview.do?bno=" + bno;
			*/
		}
		

		

		//redirect와 forward 구분하기
		//새로고침하면 게시글, 댓글 중복 생성 문제 해결
		if(command.equals("/write.do") || command.equals("/updateboard.do")) { 
			response.sendRedirect("boardlist.do");
		} else if (command.equals("/insertreply.do") || command.equals("/deletereply.do") || command.equals("/updatereply.do") || command.equals("/like.do")) {
			int bno = Integer.parseInt(request.getParameter("bno"));
			response.sendRedirect("boardview.do?bno=" + bno);
		}else{
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}
		


	}
}
