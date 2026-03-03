package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Member;
import service.MemberService;

@WebServlet(name = "MemberServlet", urlPatterns = {"/members"})
public class MemberServlet extends HttpServlet {

    private final MemberService memberService = new MemberService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                request.getRequestDispatcher("/members/create.jsp").forward(request, response);
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Member member = memberService.getMemberById(editId);
                request.setAttribute("member", member);
                request.getRequestDispatcher("/members/edit.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                memberService.deleteMember(deleteId);
                response.sendRedirect(request.getContextPath() + "/members");
                break;
            case "history":
                int historyId = Integer.parseInt(request.getParameter("id"));
                Member histMember = memberService.getMemberById(historyId);
                request.setAttribute("member", histMember);
                dao.OrderDAO orderDAO = new dao.OrderDAO();
                try {
                    request.setAttribute("orders", orderDAO.findByMemberId(historyId));
                } catch (Exception e) { e.printStackTrace(); }
                dao.MemberDAO memberDAO = new dao.MemberDAO();
                request.getRequestDispatcher("/members/history.jsp").forward(request, response);
                break;
            case "search":
                String keyword = request.getParameter("keyword");
                List<Member> results = memberService.searchMembers(keyword);
                request.setAttribute("members", results);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("/members/list.jsp").forward(request, response);
                break;
            default:
                List<Member> members = memberService.getAllMembers();
                request.setAttribute("members", members);
                request.getRequestDispatcher("/members/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            Member m = new Member();
            m.setFullName(request.getParameter("fullName"));
            m.setEmail(request.getParameter("email"));
            m.setPhone(request.getParameter("phone"));
            m.setGender(request.getParameter("gender"));
            try {
                String dob = request.getParameter("dateOfBirth");
                if (dob != null && !dob.isEmpty()) {
                    m.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(dob));
                }
            } catch (Exception e) { e.printStackTrace(); }
            String bmi = request.getParameter("bmi");
            if (bmi != null && !bmi.isEmpty()) {
                m.setBmi(new BigDecimal(bmi));
            }
            m.setMemberType("New Member");
            memberService.addMember(m);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("memberId"));
            Member m = memberService.getMemberById(id);
            m.setFullName(request.getParameter("fullName"));
            m.setEmail(request.getParameter("email"));
            m.setPhone(request.getParameter("phone"));
            m.setGender(request.getParameter("gender"));
            try {
                String dob = request.getParameter("dateOfBirth");
                if (dob != null && !dob.isEmpty()) {
                    m.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(dob));
                }
            } catch (Exception e) { e.printStackTrace(); }
            String bmi = request.getParameter("bmi");
            if (bmi != null && !bmi.isEmpty()) {
                m.setBmi(new BigDecimal(bmi));
            }
            memberService.updateMember(m);
        }

        response.sendRedirect(request.getContextPath() + "/members");
    }
}
